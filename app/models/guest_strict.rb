class GuestStrict < Guest
  attr_accessible :state, :attending_reception, :address, :phone,
                  :adults, :children, :email

  ACCESSIBLE_STATES = [:approved, :accepted, :declined, :sent]

  def self.token_find token
    where(token: token).where(state: ACCESSIBLE_STATES).first!
  end
end
