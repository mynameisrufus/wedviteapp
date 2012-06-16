class Users::PreviewController < Users::BaseController
  before_filter :find_wedding
  before_filter :spoof_guest, except: :guest

  layout 'invitations/application'

  def ourday
    render 'invitations/guests/ourday'
  end

  def thank
    render 'invitations/guests/thank'
  end

  def directions
    render 'invitations/guests/directions'
  end

  def invitation
    render inline: @wedding.stationery.render(@guest), layout: false
  end

  def stationery
    @stationery = Stationery.find params[:id]
    render inline: @stationery.render(@guest), layout: false
  end

  def guest
    @guest = Guest.find params[:id]
    render inline: @wedding.stationery.render(@guest), layout: false
  end

  protected

  def spoof_guest
    @guest = @wedding.guests.new name: Faker::Name.name, email: Faker::Internet.email
  end
end
