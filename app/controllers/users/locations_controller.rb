class Users::LocationsController < Users::BaseController
  before_filter :find_wedding

  def ceremony
    @location = @wedding.ceremony_where || Location.new
    show
  end

  def reception
    @location = @wedding.reception_where || Location.new
    show
  end

  def create_ceremony
    create "ceremony", :ceremony_where
  end

  def create_reception
    create "reception", :reception_where
  end

  def update_ceremony
    @location = @wedding.ceremony_where
    update "ceremony"
  end

  def update_reception
    @location = @wedding.reception_where
    update "reception"
  end

  protected

  def show
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @location }
    end
  end

  def create(on_failure_action, association)
    @location = Location.new(params[:location])
    respond_to do |format|
      if @location.save
        @wedding.send "#{association}=", @location
        @wedding.save
        format.html { redirect_to @wedding, notice: "Location been updated."  }
        format.json { render json: @location, status: :created, location: @location }
      else
        format.html { render action: on_failure_action }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def update(on_failure_action)
    respond_to do |format|
      if @location.update_attributes(params[:location])
        format.html { redirect_to @wedding, notice: "Location been updated."  }
        format.json { head :ok }
      else
        format.html { render action: on_failure_action }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end
end
