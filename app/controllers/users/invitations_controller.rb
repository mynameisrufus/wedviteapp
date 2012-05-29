class Users::InvitationsController < Users::BaseController
  before_filter :find_wedding
  before_filter :ensure_payment
  before_filter :find_guests

  show_subnav true

  def confirm
    respond_with @guests
  end

  # If this is the first send then update the `invite_process_started`
  # attribute, this is so we can alter the UI to reflect the changed
  # use of the app.
  #
  # Send the guests the invitation email and update state to `sent`
  # and `invited_on` as Time.now.
  def deliver
    @wedding.invite_process_started!

    @guests.each do |guest|
      mail = Invitations::Mailer.invite user: current_user, guest: guest, wedding: @wedding
      guest.invited! if mail.deliver
    end

    @wedding.evt.create! wedding: @wedding,
                         headline: "#{@guests.size} guests were sent their invitations!"

    redirect_to wedding_timeline_path(@wedding), notice: "Invitations have been sent!"
  end

  protected

  # get guests who have not been sent an invitation yet.
  def find_guests
    @guests = @wedding.guests.approved.where(invited_on: nil).order(:name)
  end

  def ensure_payment
    render 'users/payments/payment' unless @wedding.payment_made?
  end
end
