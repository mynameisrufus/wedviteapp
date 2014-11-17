# Collection class
#
# This collection object give helper methods for totals and selecting guests
# that match certain criteria.
#
# Example:
#
#   guest_list = GuestList.new(Wedding.find(1).guests.all)
#   guest_list.partner(1).approved.total => 10
#
class GuestList
  include Enumerable

  def initialize(guests, modifier = 2)
    @guests = guests
    @modifier = modifier
  end

  def total
    inject(@modifier){ |t, guest| t + guest.adults + guest.children }
  end

  def adults
    inject(@modifier){ |t, guest| t + guest.adults }
  end

  def children
    inject(0){ |t, guest| t + guest.children }
  end

  def partner(num)
    self.class.new(@guests, 1).select{ |guest| guest.partner_number == num }
  end

  def partner_one
    partner(1)
  end

  def partner_two
    partner(2)
  end

  def possibly
    select{ |guest| guest.possibly? }
  end

  def likely
    select{ |guest| guest.likely? }
  end

  def currently(state)
    select{ |guest| guest.state == state.noun.to_s }
  end

  def select(&block)
    self.class.new(@guests.select(&block), @modifier)
  end

  def each(&block)
    self.class.new(@guests.each(&block), @modifier)
  end

  def empty?
    @guests.empty?
  end
end
