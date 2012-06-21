require 'acceptance/acceptance_helper'

feature 'Forgot password', %q{
  In order to log into my account
  As a wedding collaborator
  Who has forgotten my password
  I want retrieve my password
} do

  background do
    change_subdomain :plan
  end

  scenario 'retrieve password' do
    user = User.make!
    visit '/'
    click_link 'Forgot your password?'
    fill_in 'user_email', with: user.email
    click_button "Send me reset password instructions"
    page.should have_content('You will receive an email with instructions about how to reset your password in a few minutes.')
  end
end
