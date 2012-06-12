class Designers::AttachmentsController < Designers::BaseController
  before_filter :find_stationery

  protected

  def find_stationery
    @stationery = current_designer.stationeries.find params[:stationery_id]
  end
end
