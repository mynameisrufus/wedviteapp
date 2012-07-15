class Payment < ActiveRecord::Base
  belongs_to :purchasable, polymorphic: true
  serialize :gateway_response

  validates :transaction_id, presence: true, uniqueness: {
    scope: [:purchasable_id, :purchasable_type],
    message: "item has already been transacted."
  }
end
