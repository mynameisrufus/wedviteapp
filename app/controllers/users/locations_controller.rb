class Users::LocationsController < Users::BaseController
  before_filter :find_wedding

  def create_ceremony
    location = Location.create params[:ceremony_location]

    @wedding.update_attributes ceremony_where: location,
                               ceremony_how: params[:ceremony_how]

    redirect_to wedding_details_path(@wedding), notice: "Ceremony directions have been added."
  end

  def create_reception
    location = Location.create params[:reception_location]

    @wedding.update_attributes reception_where: location,
                               reception_how: params[:reception_how]

    redirect_to wedding_details_path(@wedding), notice: "Reception directions have been added."
  end

  def update_ceremony
    @location = @wedding.ceremony_where
    @location.update_attributes params[:ceremony_location]

    @wedding.update_attributes ceremony_how: params[:ceremony_how]

    redirect_to wedding_details_path(@wedding), notice: "The ceremony directions have been updated."
  end

  def update_reception
    @location = @wedding.reception_where
    @location.update_attributes params[:reception_location]

    @wedding.update_attributes reception_how: params[:reception_how]

    redirect_to wedding_details_path(@wedding), notice: "The reception directions have been updated."
  end
end
