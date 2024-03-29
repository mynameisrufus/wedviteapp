require 'rails_helper'
require './spec/features/support/helpers'

describe 'Gift Registry describe', %q{
  In order to purchase a gift from the Gift Registry
  As a wedding guest
  I want view and claim a gift from the Gift Registry
} do

  let(:setup_guest) {
    wedding = Wedding.make!
    guest = Guest.make! wedding: wedding, state: 'accepted'
    [guest, wedding]
  }


  it 'claim a gift' do
    guest, wedding = *setup_guest
    gift_registry = GiftRegistry.make! wedding: wedding, active: true
    gift = Gift.make! gift_registry: gift_registry

    visit invitation_url(guest.token, subdomain: 'invitations')
    click_link 'Gift Registry'
    click_link 'Claim this gift.'

    gift.reload.guest.should eq guest
  end

  it 'unclaim a gift' do
    guest, wedding = *setup_guest
    gift_registry = GiftRegistry.make! wedding: wedding, active: true
    gift = Gift.make! gift_registry: gift_registry, guest: guest

    visit invitation_url(guest.token, subdomain: 'invitations')
    click_link 'Gift Registry'
    click_link 'Un-claim this gift.'

    gift.reload.guest.should be_nil
  end

  pending 'should not be able to claim gift if already claimed'
end
