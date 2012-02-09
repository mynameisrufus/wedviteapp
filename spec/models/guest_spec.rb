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

  it "should return siblings" do
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
end
