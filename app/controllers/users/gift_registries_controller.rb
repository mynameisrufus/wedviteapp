class Users::GiftRegistriesController < Users::BaseController
  before_filter :find_wedding

  show_subnav true

  def show
  end

  def create
    @wedding.gift_registry.attributes = gift_registry_params

    respond_to do |format|
      if @wedding.gift_registry.save
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift Registry details saved." }
      else
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Could not save the Gift Registry details" }
      end
    end
  end

  def update
    respond_to do |format|
      if @wedding.gift_registry.update_attributes(gift_registry_params)
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift Registry details saved." }
      else
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Could not save the Gift Registry details" }
      end
    end
  end

  protected

  def gift_registry_params
    params.require(:gift_registry).permit(:details, :active)
  end
end
