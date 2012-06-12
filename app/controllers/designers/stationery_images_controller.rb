class Designers::StationeryImagesController < Designers::AttachmentsController
  def new
    @image = StationeryImage.new
    respond_with @image
  end

  def edit
    @image = @stationery.images.find params[:id]
    respond_with @image
  end

  def create
    @image = @stationery.new params[:stationery_image]

    respond_to do |format|
      if @image.save
        format.html { redirect_to stationery_images_path(@stationery), notice: 'Image created.' }
        format.json { render json: @image, status: :created, location: @image }
      else
        format.html { redirect_to root_path, notice: "Could not upload image" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @image = @stationery.images.find params[:id]

    respond_to do |format|
      if @image.update_attributes(params[:stationery_image])
        format.html { redirect_to stationery_images_path(@stationery), notice: 'Wedding was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @image.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @image = @stationery.images.find params[:id]
    @image.destroy

    respond_to do |format|
      format.html { redirect_to stationery_images_path }
      format.json { head :ok }
    end
  end
end
