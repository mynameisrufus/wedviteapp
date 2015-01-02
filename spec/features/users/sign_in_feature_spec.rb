require 'rails_helper'
require './spec/features/support/helpers'

describe 'Sign in describe', %q{
  In order to plan my wedding invitations
  As a wedding collaborator
  I want sign into the application
} do

  before do
    change_subdomain :plan
  end

  it 'sign in' do
    user = User.make!
    sign_in_with user.email, user.password
    page.should have_content(user.name)
  end

  it 'sign out' do
    user = User.make!
    sign_in_with user.email, user.password
    sign_out
    current_url.should eq "http://wedvite.dev/"
  end

  it 'get redirected if signed in' do
    user = User.make!
    sign_in_with user.email, user.password
    visit site_root_path
    current_url.should eq "http://plan.example.com/"
  end
end
