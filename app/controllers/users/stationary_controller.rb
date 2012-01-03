class Users::StationaryController < Users::BaseController
  def index
    @stationary = Stationary.published.sorted(params[:sort], 'popularity ASC').page(params[:page]).per(50).all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @stationary }
    end
  end

  def choose
    @stationary         = Stationary.find(params[:stationary_id])
    @wedding            = Wedding.find(params[:wedding_id])
    @current_stationary = @wedding.stationary

    respond_to do |format|
      if @wedding.update_attributes(stationary_id: @stationary.id)
        @current_stationary.decrement_counter(:popularity) unless @current_stationary.nil?
        @stationary.increment_counter(:popularity)
        format.html { redirect_to @wedding, notice: "#{@stationary.name} was selected for #{@wedding.name}." }
        format.json { head :ok }
      else
        format.html { render action: "index" }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end
end
