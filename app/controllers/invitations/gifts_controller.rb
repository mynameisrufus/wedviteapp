class Invitations::GiftsController < Invitations::BaseController
  before_filter :find_gift

  def claim
    respond_to do |format|
      if @gift.unclaimed?
        @gift.claim @guest
        format.html { redirect_to invitation_path(@guest.token), notice: "You have claimed the gift." }
      else
        format.html { redirect_to invitation_path(@guest.token), notice: "The gift has already been claimed." }
      end
    end
  end

  def unclaim
    respond_to do |format|
      if @gift.claimed_by @guest
        @gift.unclaim
        format.html { redirect_to invitation_path(@guest.token), notice: "You have unclaimed the gift." }
      else
        format.html { redirect_to invitation_path(@guest.token), notice: "The gift has been claimed by someone else." }
      end
    end
  end

  protected

  def find_gift
    @gift = @wedding.gift_registry.gifts.find params[:id]
  end
end
