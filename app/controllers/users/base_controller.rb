class Users::BaseController < ApplicationController
  layout 'users/application'

  before_filter :authenticate_user!
end
