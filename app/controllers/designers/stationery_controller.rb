class Designers::StationeryController < Designers::BaseController
  before_filter :find_stationery, except: [:new, :create]

  def edit
    respond_with @stationery
  end

  def build
    respond_with @stationery
  end

  def preview
    render inline: @stationery.render_dev(spoof_guest), layout: false
  end

  def create
    @stationery = Stationery.new stationery_params
    respond_to do |format|
      if @stationery.save
        format.html { redirect_to build_stationery_path(@stationery), notice: 'Stationery was successfully created.' }
        format.json { render json: "success".to_json  }
      else
        format.html { render 'designers/dashboard/home' }
        format.json { render json: @stationery.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @stationery.update_attributes stationery_params
        format.html { redirect_to edit_stationery_path(@stationery), notice: 'Stationery was successfully updated.' }
        format.json { render json: "success".to_json  }
      else
        format.html { render action: "edit" }
        format.json { render json: @stationery.errors, status: :unprocessable_entity }
      end
    end
  end

  def deploy
    respond_to do |format|
      if @stationery.deploy!
        format.html { redirect_to edit_stationery_path(@stationery), notice: 'Stationery was successfully deployed.' }
        format.json { render json: "success".to_json  }
      else
        format.html { render action: "edit" }
        format.json { render json: @stationery.errors, status: :unprocessable_entity }
      end
    end
  end

  protected

  def find_stationery
    @stationery = current_designer.stationeries.find params[:id]
  end

  def spoof_guest
    wedding = Spoof.wedding wording: @stationery.example_wording_dev
    Spoof.guest wedding: wedding
  end

  def stationery_params
    params.require(:stationery).permit(:name,
                                       :style,
                                       :price,
                                       :agency_id,
                                       :html_dev,
                                       :description,
                                       :desktop,
                                       :mobile,
                                       :print,
                                       :preview,
                                       :example_wording_dev)
  end
end
