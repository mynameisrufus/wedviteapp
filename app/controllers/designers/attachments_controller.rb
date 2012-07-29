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
    @resource = association.new params[param_key]

    respond_to do |format|
      if @resource.save
        format.html { redirect_to resources_path, notice: "#{association_singular} uploaded." }
        format.json { render json: @resource, status: :created, location: @image }
      else
        format.html { redirect_to root_path, notice: "Could not upload #{association_singular}" }
        format.json { render json: @resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @resource = association.find params[:id]

    respond_to do |format|
      if @resource.update_attributes params[param_key]
        format.html { redirect_to resources_path, notice: "#{association_singular} uploaded." }
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
    :"stationery_#{association_singular}"
  end

  def resources_path
    send(:"stationery_#{self.class.assoc}_path", @stationery)
  end

  def association_singular
    self.class.assoc.to_s.singularize
  end

  def find_stationery
    @stationery = current_designer.stationeries.find params[:stationery_id]
  end
end
