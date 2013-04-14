class Users::ThanksController < Users::BaseController
  before_filter :find_wedding
  before_filter :find_guests

  show_subnav true

  def confirm
    respond_with @guests
  end

  def deliver
    @wedding.thank_process_started!

    mail = Invitations::ThankMailer.prepare sender: current_user,
                                            guests: @guests,
                                            wedding: @wedding
    Guest.thanked! @guests if mail.deliver

    @wedding.evt.create! wedding: @wedding,
                         headline: "#{@guests.size} guests were sent thank you emails"

    redirect_to wedding_timeline_path(@wedding), notice: "Thank you emails have been sent!"
  end

  protected

  def find_guests
    @guests = @wedding.guests.accepted.where(thanked_on: nil).order(:name)
  end
end
