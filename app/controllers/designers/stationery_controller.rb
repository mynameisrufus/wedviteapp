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
    @stationery = Stationery.new params[:stationery]
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
      if @stationery.update_attributes params[:stationery]
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
    wedding = Wedding.new({
      name: "Preview wedding",
      wording: @stationery.example_wording_dev,
      partner_one_name: Faker::Name.name,
      partner_two_name: Faker::Name.name,
      ceremony_when: Time.now + 10.days,
      ceremony_when_end: Time.now + 10.days + 2.hours,
      ceremony_when: Time.now + 10.days + 5.hours,
      ceremony_when_end: Time.now + 10.days + 10.hours
    })

    guest = Guest.new({
      wedding: wedding,
      name: Faker::Name.name,
      email: Faker::Internet.email
    })
  end
end
