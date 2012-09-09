class Users::PreviewController < Users::BaseController
  before_filter :find_wedding

  layout 'invitations/application'

  def ourday
    @guest = spoof_guest
    render 'invitations/guests/ourday'
  end

  def thank
    @guest = spoof_guest
    render 'invitations/guests/thank'
  end

  def directions
    @guest = spoof_guest
    render 'invitations/guests/directions'
  end

  def invitation
    render inline: @wedding.stationery.render(random_guest || spoof_guest), layout: false
  end

  def stationery
    @stationery = Stationery.find params[:id]
    render inline: @stationery.render(random_guest || spoof_guest), layout: false
  end

  def guest
    @guest = Guest.find params[:id]
    render inline: @wedding.stationery.render(@guest), layout: false
  end

  protected

  def spoof_guest
    @wedding.guests.new name: Faker::Name.name, email: Faker::Internet.email
  end

  def random_guest
    offset = rand @wedding.guests.count
    @wedding.guests.first offset: offset
  end
end
