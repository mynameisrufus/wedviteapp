module HelperMethods
  def change_subdomain subdomain
    Capybara.default_host = subdomain.nil? ? "http://example.com" : "http://#{subdomain}.example.com"
  end


  # Create a wedding and a user and make the user a collaborator on
  # the wedding. If we use this block for every test we should be
  # completely isolated. No state ruining our day.
  def wedup!
    stationery   = Stationery.make!
    wedding      = Wedding.make! stationery: stationery
    user         = User.make!
    collaborator = Collaborator.make! user_id: user.id, wedding_id: wedding.id, role: 'invite'

    [wedding, user, collaborator]
  end

  def sign_in_with email, password
    visit '/'
    page.should have_content('Sign in')
    fill_in 'user_email', with: email
    fill_in 'user_password', with: password
    click_button 'Sign in'
  end

  def sign_out
    click_link 'Sign out'
  end

  def navigate_to_wedding wedding, user
    sign_in_with user.email, user.password
    visit root_path
    click_link wedding.name
    click_link "Guest List"
  end

  def show!
    save_and_open_page
  end
end

RSpec.configuration.include HelperMethods, type: :acceptance
