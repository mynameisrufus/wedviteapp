require 'spec_helper'

describe PromotionalCode do
  it 'should claim a code' do
    PromotionalCode.make! code: 'Bride2Be'

    promo = PromotionalCode.claim('Bride2Be')
    expect(promo.claimed).to eq(1)
  end

  it 'should raise if promo code missing' do
    expect(->{ PromotionalCode.claim('Blurg') }).to raise_error(PromotionalCode::InvalidCodeError)
  end

  it 'should be invalid if the amount claimed is the limit' do
    PromotionalCode.make! code: 'Bride2Be1', claimed: 500, limit: 500
    expect(->{ PromotionalCode.claim('Bride2Be1') }).to raise_error(PromotionalCode::LimitExcededError)
  end

  it 'should be invalid if the promotional code is after the expires date' do
    PromotionalCode.make! code: 'Bride2Be2', expires_on: Time.now - 1.day
    expect(->{ PromotionalCode.claim('Bride2Be2') }).to raise_error(PromotionalCode::ExpiredError)
  end
end
