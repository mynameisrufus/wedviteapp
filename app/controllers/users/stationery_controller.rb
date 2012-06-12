class Users::StationeryController < Users::BaseController
  before_filter :find_wedding
  respond_to :html

  def choose
    @stationery         = Stationery.find(params[:stationery_id])
    @wedding            = Wedding.find(params[:wedding_id])
    @current_stationery = @wedding.stationery

    respond_to do |format|
      if @wedding.update_attributes!(stationery_id: @stationery.id)
        Stationery.decrement_counter(:popularity, @current_stationery.id) unless @current_stationery.nil?
        Stationery.increment_counter(:popularity, @stationery.id)
        format.html { redirect_to wedding_invitations_path(@wedding), notice: "#{@stationery.name} was selected for #{@wedding.name}." }
        format.json { head :ok }
      else
        format.html { render action: "index" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end
end
