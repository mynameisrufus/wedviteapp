class Payment < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true
  serialize :gateway_response
end
