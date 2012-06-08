require 'spec_helper'

describe Stationary do
  context :associations do
    it "should have many images" do
      Stationary.make.respond_to?(:images).should be_true
    end

    it "should have many assets" do
      Stationary.make.respond_to?(:assets).should be_true
    end
  end

  context :rendering do
    it "should render a template with the image url" do
      stationary = Stationary.make html: "{% image tweee.png %}"
      image      = stationary.images.new attachment_file_name: 'tweee.png'
      wedding    = Wedding.make
      guest      = Guest.make wedding: wedding
      stationary.render(guest).should_not eq "No images with filename tweee.png could be found"
    end

    it "should render a template with a missing asset url" do
      stationary = Stationary.make html: "{% asset missing.js %}"
      wedding    = Wedding.make
      guest      = Guest.make wedding: wedding
      stationary.render(guest).should eq "No assets with filename missing.js could be found"
    end

    it "should render guest, wedding and url drops" do
      stationary = Stationary.make html: "{{ urls.rsvp }} {{ urls.decline }} {{ guest.name }} {{ wedding.name }}"
      wedding    = Wedding.make
      guest      = Guest.make wedding: wedding
      stationary.render(guest, "#accept", "#decline").should eq "#accept #decline #{ guest.name } #{ wedding.partner_one_name } & #{ wedding.partner_two_name }"
    end
  end
end
