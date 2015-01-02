require 'rails_helper'
require './spec/features/support/helpers'

describe 'Sign up describe', %q{
  In order to use wedvite
  As a potential user
  I want sign up
} do

  before do
    change_subdomain nil
  end

  it 'sign up' do
    visit '/'
    click_link "Sign up for free"
    fill_in "user[first_name]", with: "Motso"
    fill_in "user[last_name]",  with: "Motta"
    fill_in "user[email]",      with: "motso@matamata.com"
    fill_in "user[password]",   with: "matamatarocks"
    click_button "Sign up"
    page.should have_content "Welcome! You have signed up successfully."
  end
end
