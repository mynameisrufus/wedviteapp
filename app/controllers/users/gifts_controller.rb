class Users::GiftsController < Users::BaseController
  before_filter :find_wedding
  before_filter :find_gift, only: %w(update destroy)

  def create
    @gift = @wedding.gift_registry.gifts.new gift_params

    respond_to do |format|
      if @gift.save
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift added to the Registry" }
      else
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Could not add the gift to the Registry" }
      end
    end
  end

  def update
    respond_to do |format|
      if @gift.update_attributes gift_params
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift updated." }
      else
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Could not update the gift." }
      end
    end
  end

  def destroy
    respond_to do |format|
      unless @gift.claimed?
        @gift.destroy
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift removed." }
      else
        format.html { redirect_to wedding_gift_registry_path(@wedding), notice: "Gift could not be remove because somebody has already purchased it" }
      end
    end
  end

  protected

  def find_gift
    @gift = @wedding.gift_registry.gifts.find params[:id]
  end

  def gift_params
    params.require(:gift).permit(:description,
                                 :url,
                                 :price)
  end
end
