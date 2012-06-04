# Be sure to restart your server when you modify this file.

WeddingInvitor::Application.config.session_store :cookie_store, key: 'wedvite_session', domain: {
  production: '.wedviteapp.com',
  staging: '.wedvite.net',
  development: '.wedvite.dev',
  test: :all
}.fetch(Rails.env.to_sym)

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# WeddingInvitor::Application.config.session_store :active_record_store
