require 'spec_helper'

describe Wedding do
  context :wording do
    it "should be invalid if guest name tag is not present" do
      wedding = Wedding.make wording: <<EOL
# This invitation is missing the guest tag
EOL
      expect(wedding).not_to be_valid
    end

    it "should be valid if guest name tag is present" do
      wedding = Wedding.make wording: <<EOL
# {{ guest.name }}
EOL
      expect(wedding).to be_valid
    end
  end
end
