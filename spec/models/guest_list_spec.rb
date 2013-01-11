require 'spec_helper'

describe Guest::List do

  let(:adults) {
    2
  }

  let(:children) {
    2
  }

  let(:guests) {
    Guest::STATES.inject([]) do |list, state|
      [1, 2].each do |partner_number|
        list << Guest.make(partner_number: partner_number, state: state[:noun], adults: adults, children: adults)
      end
      list
    end
  }

  it "should give the total number of guests including partners (total)" do
    expected = ( ( Guest::STATES.count * ( adults + children ) ) * 2 ) + 2
    subject = Guest::List.new guests
    subject.total.should eq expected
  end

  it "should give the total number of guests including partners (each side)" do
    expected = ( ( Guest::STATES.count * ( adults + children ) ) ) + 1
    subject = Guest::List.new guests
    subject.partner(1).total.should eq expected
  end

  it "should give the total number of possible guests (total)" do
    expected = ( ( Guest::STATES.possibly.count * ( adults + children ) ) * 2 ) + 2
    subject = Guest::List.new guests
    subject.possibly.total.should eq expected
  end

  it "should give the total number of likely guests (total)" do
    expected = ( ( Guest::STATES.likely.count * ( adults + children ) ) * 2 ) + 2
    subject = Guest::List.new guests
    subject.likely.total.should eq expected
  end

  it "should give the total number of approved guests (total)" do
    expected = ( ( adults + children ) * 2 ) + 2
    subject = Guest::List.new guests
    subject.approved.total.should eq expected
  end

  it "should give the total number of approved guests (each side)" do
    expected = ( adults + children ) + 1
    subject = Guest::List.new guests
    subject.partner(1).approved.total.should eq expected
  end
end
