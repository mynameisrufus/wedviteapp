class Designers::BaseController < ApplicationController
  layout 'designers/application'

  before_filter :authenticate_designer!

  respond_to :html, :json
end
