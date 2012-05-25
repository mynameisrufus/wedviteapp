class Users::StationaryController < Users::BaseController
  before_filter :find_wedding
  respond_to :html

  def choose
    @stationary         = Stationary.find(params[:stationary_id])
    @wedding            = Wedding.find(params[:wedding_id])
    @current_stationary = @wedding.stationary

    respond_to do |format|
      if @wedding.update_attributes!(stationary_id: @stationary.id)
        Stationary.decrement_counter(:popularity, @current_stationary.id) unless @current_stationary.nil?
        Stationary.increment_counter(:popularity, @stationary.id)
        format.html { redirect_to wedding_invitations_path(@wedding), notice: "#{@stationary.name} was selected for #{@wedding.name}." }
        format.json { head :ok }
      else
        format.html { render action: "index" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end
end
