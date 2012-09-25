require 'spec_helper'

describe Stationery do
  it "should have valid format in blueprint" do
    Stationery.make.should be_valid
  end

  context :associations do
    it "should have many images" do
      Stationery.make.respond_to?(:images).should be_true
    end

    it "should have many assets" do
      Stationery.make.respond_to?(:assets).should be_true
    end
  end

  context :rendering do
    it "should render a template with the image url" do
      stationery = Stationery.make html: "{% image tweee.png %}"
      image      = stationery.images.new attachment_file_name: 'tweee.png'
      wedding    = Wedding.make
      guest      = Guest.make wedding: wedding
      stationery.render(guest).should_not eq "No images with filename tweee.png could be found"
    end

    it "should render a template with a missing asset url" do
      stationery = Stationery.make html: "{% asset missing.js %}"
      wedding    = Wedding.make
      guest      = Guest.make wedding: wedding
      stationery.render(guest).should eq "No assets with filename missing.js could be found"
    end

    it "should render guest, wedding and url drops" do
      stationery = Stationery.make html: "{{ urls.accept }} {{ urls.decline }} {{ guest.name }} {{ wedding.name }}"
      wedding    = Wedding.make
      guest      = Guest.make wedding: wedding
      stationery.render(guest, "#accept", "#decline").should eq "#accept #decline #{ guest.name } #{ wedding.partner_one_name } & #{ wedding.partner_two_name }"
    end

    it "should render the names of partner one and two" do
      stationery = Stationery.make html: "{{ partner_one.initial }} & {{ partner_two.name }}"
      wedding    = Wedding.make partner_one_name: "Ginni", partner_two_name: "Rufus"
      guest      = Guest.make wedding: wedding
      stationery.render(guest).should match /G & Rufus/
    end

    it "should render the initails of partner one and two" do
      stationery = Stationery.make html: "{{ wedding.initials }}"
      wedding    = Wedding.make partner_one_name: "Ginni", partner_two_name: "Rufus"
      guest      = Guest.make wedding: wedding
      stationery.render(guest).should match /G & R/
    end
  end

  context :markup_validation do
    it "should be invalid if not in the actions div" do
      stationery = Stationery.make html: <<EOL
<div class="invalid-div">
  <a href="{{ urls.accept }}">Accept</a>
  <d href="{{ urls.decline }}">Decline</a>
</div>
EOL
      stationery.should_not be_valid
    end

    it "should be invalid if link missing" do
      stationery = Stationery.make html: <<EOL
<div class="actions">
  <a href="{{ urls.accept }}">Accept</a>
</div>
EOL
      stationery.should_not be_valid
    end

    it "should be invalid if wrong link" do
      stationery = Stationery.make html: <<EOL
<div class="actions">
  <a href="{{ urls.rsvp }}">Accept</a>
  <d href="{{ urls.decline }}">Decline</a>
</div>
EOL
      stationery.should_not be_valid
    end
  end

  context :deploying do
    it "should copy the development code to the live code on publish" do
      stationery = Stationery.make
      stationery.deploy!
      stationery.html.should eq stationery.html_dev
    end

    it "should set the published at" do
      stationery = Stationery.make
      stationery.deploy!
      stationery.deployed_at.should_not be_nil
    end
  end
end
