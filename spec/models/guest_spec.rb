require 'spec_helper'

describe Guest do
  before(:each) do
    @wedding = Wedding.make!
  end

  it "should position new guest at end of list" do
    guest_one = Guest.make! wedding_id: @wedding.id, partner_number: 1
    guest_two = Guest.make! wedding_id: @wedding.id, partner_number: 1
    guest_two.position.should be > guest_one.position
  end

  it "should return siblings of the guest with the same state and partner number" do
    guest_one   = Guest.make! wedding_id: @wedding.id, partner_number: 1
    guest_two   = Guest.make! wedding_id: @wedding.id, partner_number: 1

    guest_one.siblings.size.should eq 1
  end

  it "should move position" do
    guest_one   = Guest.make! wedding_id: @wedding.id, partner_number: 1
    guest_two   = Guest.make! wedding_id: @wedding.id, partner_number: 1
    guest_three = Guest.make! wedding_id: @wedding.id, partner_number: 1

    guest_three.move 1

    guest_one.reload.position.should be 0
    guest_three.reload.position.should be 1
    guest_two.reload.position.should be 2
  end

  pending "invited_to_reception should always be true when attending_reception is false"

  pending "attending_reception should always be false when invited_to_reception is false"
end
