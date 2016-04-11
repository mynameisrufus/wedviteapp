class Users::DateAndTimeController < Users::BaseController
  before_filter :find_wedding

  def update
    respond_to do |format|
      if @wedding.update_attributes(wedding_params)
        format.html { redirect_to wedding_path(@wedding), notice: 'Date and time updated' }
        format.json { head :ok }
      else
        format.html { render action: :show }
        format.json { render json: @wedding.errors, status: :unprocessable_entity }
      end
    end
  end

  def wedding_params
    params.require(:wedding).permit(
      :name,
      :wording,
      :save_the_date_wording,
      :ceremony_only_wording,
      :respond_deadline,
      :ceremony_when,
      :ceremony_how,
      :ceremony_what,
      :has_reception,
      :reception_when,
      :reception_how,
      :reception_what,
      :partner_one_name,
      :partner_two_name,
      :ceremony_when_end,
      :reception_when_end,
      :thank_you_wording
    )
  end
end
