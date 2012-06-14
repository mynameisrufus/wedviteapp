require 'acceptance/acceptance_helper'

feature 'Sign in feature', %q{
  In order to plan my wedding invitations
  As a wedding collaborator
  I want sign into the application
} do

  background do
    change_subdomain :plan
  end

  scenario 'sign in' do
    user = User.make!
    sign_in_with user.email, user.password
    page.should have_content(user.name)
  end

  scenario 'sign out' do
    user = User.make!
    sign_in_with user.email, user.password
    sign_out
    current_url.should eq "http://wedvite.dev/"
  end
end
