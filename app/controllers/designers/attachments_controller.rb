class Designers::AttachmentsController < Designers::BaseController
  before_filter :find_stationery

  def index
    respond_with association
  end

  def edit
    @resource = association.find params[:id]
    respond_with @resource
  end

  def create
    @resource = association.new params.require(param_key).permit(:attachment)

    respond_to do |format|
      if @resource.save
        format.html { redirect_to resources_path, notice: "#{association_name_singular} uploaded." }
        format.json { render json: @resource, status: :created, location: @image }
      else
        format.html { redirect_to root_path, notice: "Could not upload #{association_name_singular}" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @resource = association.find params[:id]

    respond_to do |format|
      if @resource.update_attributes params.require(param_key).permit(:attachment)
        format.html { redirect_to resources_path, notice: "#{association_name_singular} uploaded." }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @resource = association.find params[:id]
    @resource.destroy

    respond_to do |format|
      format.html { redirect_to resources_path }
      format.json { head :ok }
    end
  end

  protected

  def param_key
    :"stationery_#{association_name_singular}"
  end

  def resources_path
    send(:"stationery_#{association_name}_path", @stationery)
  end

  def association_name_singular
    association_name.to_s.singularize
  end

  def association
    @stationery.send association_name
  end

  def find_stationery
    @stationery = current_designer.stationeries.find params[:stationery_id]
  end
end
