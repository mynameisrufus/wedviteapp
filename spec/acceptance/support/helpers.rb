module HelperMethods
  def change_subdomain(subdomain)
    Capybara.default_host = "http://#{subdomain}.example.com"
  end

  def sign_in_with(options)
    visit '/'
    page.should have_content('Sign in')
    fill_in 'user_email', with: options[:email]
    fill_in 'user_password', with: options[:password]
    click_button 'Sign in'
  end

  def sign_out
    click_link 'Sign out'
  end
end

RSpec.configuration.include HelperMethods, :type => :acceptance
