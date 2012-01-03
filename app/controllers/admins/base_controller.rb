class Admins::BaseController < ApplicationController
  layout 'admins/application'

  before_filter :authenticate_admin!
end
