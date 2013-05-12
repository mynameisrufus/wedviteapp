require 'acceptance/acceptance_helper'

feature 'Feedback feature', %q{
  In order give feedback on the app
  As a user
  I need to send feedback via a form
} do

  background do
    change_subdomain :plan
  end

  it "send feedback to app support" do
    user = User.make!
    sign_in_with user.email, user.password

    click_link 'Feedback and Support'

    fill_in 'feedback', with: 'hello!'

    click_button 'Send'

    page.should have_content "Thank you for your feedback."
  end
end
