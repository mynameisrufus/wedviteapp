class Users::InvitationsController < Users::BaseController
  before_filter :find_wedding

  def confirm
    @guests = @wedding.guests.approved.where(invited_on: nil)
    respond_with @guests
  end

  def deliver
    @guests  = @wedding.guests.approved.where(invited_on: nil)
    unless @wedding.invite_process_started?
      @wedding.update_attributes(invite_process_started: true, invite_process_started_at: Time.now)
    end
    @guests.each do |guest|
      mail = Invitations::Mailer.invite user: current_user, guest: guest, wedding: @wedding
      mail.deliver
      guest.update_attribute(:invited_on, Time.now)
    end
  end
end
