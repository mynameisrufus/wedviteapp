class Users::GiftRegistriesController < Users::BaseController
  before_filter :find_wedding

  show_subnav true

  def show
    @gift_registry = @wedding.gift_registry || GiftRegistry.new(wedding: @wedding)
  end

  def create
    @gift_registry = GiftRegistry.new gift_registry_params
    @gift_registry.wedding = @wedding

    respond_to do |format|
      if @gift_registry.save
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift Registry details saved." }
      else
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Could not save the Gift Registry details" }
      end
    end
  end

  def update
    @gift_registry = @wedding.gift_registry

    respond_to do |format|
      if @gift_registry.update_attributes gift_registry_params
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift Registry details saved." }
      else
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Could not save the Gift Registry details" }
      end
    end
  end

  protected

  def gift_registry_params
    params.require(:gift_registry).permit(:details)
  end
end
