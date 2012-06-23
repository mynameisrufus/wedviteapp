require 'spec_helper'

describe PromotionalCode do
  it "should claim a code" do
    PromotionalCode.make! code: "Bride2Be"

    promo = PromotionalCode.claim("Bride2Be")
    promo.claimed.should eq 1
  end

  it "should raise if promo code missing" do
    block = lambda{ PromotionalCode.claim("Blurg") }
    error = PromotionalCode::InvalidCodeError
    block.should raise_error(error)
  end

  it "should be invalid if the amount claimed is the limit" do
    block = lambda{ PromotionalCode.claim("Bride2Be1") }
    error = PromotionalCode::LimitExcededError

    PromotionalCode.make! code: "Bride2Be1", claimed: 500, limit: 500
    block.should raise_error(error)
  end

  it "should be invalid if the promotional code is after the expires date" do
    block = lambda{ PromotionalCode.claim("Bride2Be2") }
    error = PromotionalCode::ExpiredError

    PromotionalCode.make! code: "Bride2Be2", expires_on: Time.now - 1.day
    block.should raise_error(error)
  end
end
