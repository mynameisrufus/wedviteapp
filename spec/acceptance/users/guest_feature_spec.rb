require 'acceptance/acceptance_helper'

feature 'Guest feature', %q{
  In order to orginise my invitations
  As a wedding collaborator
  I want manage guests
} do

  let :singular do
    wedding, user, collaborator = wedup!
    guest = Guest.make! wedding_id: wedding.id,
                        adults: 1,
                        children: 0
    navigate_to_wedding wedding, user
    guest
  end

  let :plural do
    wedding, user, collaborator = wedup!
    guest = Guest.make! wedding_id: wedding.id,
                        adults: 2,
                        children: 1
    navigate_to_wedding wedding, user
    guest
  end

  background do
    change_subdomain :plan
  end

  scenario 'add a guest to wedding' do
    wedding, user, collaborator = wedup!
    navigate_to_wedding wedding, user

    click_link "Add guest"

    fill_in 'Name',            with: "Roger and Sally"
    fill_in 'Email',           with: "roger@aol.com"
    fill_in 'Address',         with: "1 White Picket Fench lane"
    fill_in 'Phone',           with: "+61 487 738 874"
    fill_in 'guest[adults]',   with: 2
    fill_in 'guest[children]', with: 0
    choose wedding.partner_one_name
    click_button 'Save'

    page.should have_content('Roger and Sally have been added to the list.')
  end

  scenario 'edit an existing guest' do
    wedding, user, collaborator = wedup!
    guest = Guest.make! wedding_id: wedding.id,
                        adults: 2,
                        children: 1
    navigate_to_wedding wedding, user

    click_link "edit"

    fill_in 'Name',            with: "Bob and Roger"
    fill_in 'Adults',          with: 2
    click_button 'Save changes'

    page.should have_content('Bob and Roger have been updated.')
  end

  def change_status state
    click_link "status"
    click_button state
  end

  %w(approved rejected accepted declined tentative).each do |state|
    scenario "#{state} a guest (singular)" do
      guest       = singular
      translation = I18n.t "state.#{state}"

      change_status translation[:verb]
      page.should have_content("#{guest.name} is now #{translation[:noun]}")
    end

    scenario "#{state} a guest (plural)" do
      guest       = plural
      translation = I18n.t "state.#{state}"

      change_status translation[:verb]
      page.should have_content("#{guest.name} are now #{translation[:noun]}")
    end
  end

  scenario 'remind a guest with a reminder email' do
    wedding, user, collaborator = wedup!
    guest = Guest.make! wedding_id: wedding.id,
                        state: 'sent'
    navigate_to_wedding wedding, user

    click_link "remind"

    page.should have_content("#{guest.name} has been sent a reminder email.")
  end
end
