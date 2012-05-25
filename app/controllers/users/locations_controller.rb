class Users::LocationsController < Users::BaseController
  before_filter :find_wedding

  def create_ceremony
    create :reception_where, :reception_location
  end

  def create_reception
    create :reception_where, :reception_location
  end

  def update_ceremony
    @location = @wedding.ceremony_where
    update :ceremony_location
  end

  def update_reception
    @location = @wedding.reception_where
    update :reception_location
  end

  protected

  def create(association, params_key)
    @location = Location.new(params[params_key])
    if @location.save
      @wedding.send "#{association}=", @location
      @wedding.save
      redirect_to wedding_details_path(@wedding), notice: "#{params_key.to_s.humanize} has been added."
    end
  end

  def update(params_key)
    @location.update_attributes(params[params_key])
    redirect_to wedding_details_path(@wedding), notice: "#{params_key.to_s.humanize} has been updated."
  end
end
