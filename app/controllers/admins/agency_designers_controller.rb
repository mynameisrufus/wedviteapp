class Admins::AgencyDesignersController < Admins::BaseController
  before_filter :find_agency

  def new
    @agency_designer = AgencyDesigner.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @agency_designer }
    end
  end

  def edit
    @agency_designer = AgencyDesigner.find(params[:id])
  end

  def create
    respond_to do |format|
      @agency_designer = AgencyDesigner.add_or_invite_designer_to_agency email: params[:email],
                                                                         agency: @agency,
                                                                         admin: params[:admin]
      if @agency_designer
        format.html { redirect_to(@agency, :notice => 'User was added to account.') }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @agency_designer = AgencyDesigner.find params[:id]

    respond_to do |format|
      if @agency_designer.update_attributes params[:agency_designer]
        format.html { redirect_to @agency, notice: 'Designer was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @agency_designer.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @agency_designer = AgencyDesigner.find params[:id]
    @agency_designer.destroy

    respond_to do |format|
      format.html { redirect_to agency_path(@agency) }
      format.json { head :ok }
    end
  end

  protected

  def find_agency
    @agency = Agency.find params[:agency_id]
  end
end
