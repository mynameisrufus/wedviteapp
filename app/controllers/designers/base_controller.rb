class Designers::BaseController < ApplicationController
  layout 'designers/application'

  before_filter :authenticate_designer!
end
