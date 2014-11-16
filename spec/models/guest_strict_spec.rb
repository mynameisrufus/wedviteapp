require 'spec_helper'

describe Guest do
  it 'raise 404 if not in allowed states' do
    wedding = Wedding.make!
    guest   = Guest.make! wedding: wedding, state: 'rejected'
    expect(-> { GuestStrict.token_find(guest.token) }).to raise_error(ActiveRecord::RecordNotFound)
  end

  pending 'prevent guest from increasing number of adults'

  pending 'prevent guest from increasing number of children'

  pending 'only allow guest to change between accepted and declined states'

  pending 'only allow params on page to be updated'

  pending 'only allow update of status etc before the wedding respond by date'
end
