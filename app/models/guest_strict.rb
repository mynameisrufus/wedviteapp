class GuestStrict < Guest
  ACCESSIBLE_STATES = [:approved, :accepted, :declined, :sent, :thanked]

  def self.token_find token
    where(token: token).where(state: ACCESSIBLE_STATES).first!
  end
end
