require 'acceptance/acceptance_helper'

feature 'Sign in feature', %q{
  In order to plan my wedding invitations
  As a wedding collaborator
  I want sign into the application
} do

  background do
    change_subdomain :plan
    @user = User.make!
  end

  scenario 'sign in' do
    sign_in_with email: @user.email, password: @user.password
    page.should have_content('Signed in successfully.')
  end

  scenario 'sign out' do
    sign_in_with email: @user.email, password: @user.password
    sign_out
    page.should have_content('Sign in')
  end
end
