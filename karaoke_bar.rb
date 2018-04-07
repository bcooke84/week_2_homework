class Karaoke_bar

  attr_reader :name, :rooms, :guests, :capacity, :entry_fee, :till

  def initialize(name, rooms, guests, capacity, entry_fee, till)
    @name = name
    @rooms = rooms
    @guests = guests
    @capacity = capacity
    @entry_fee = entry_fee
    @till = till
  end

  def admit_guest_to_bar(guest)
    if check_capacity == false
      p "There's no room at the inn!"
    elsif guest_has_enough_money(guest) == false
      p "There's a cash machine round the corner!"
    else @guests.push(guest)
      add_entry_fee_to_till
      guest.pay_entry_fee(@entry_fee)
    end
  end

  def guest_exits_bar(guest)
    @guests.delete(guest)
  end

  def check_capacity()
    if @guests.count <= @capacity - 1
      return true
    else return false
    end
  end

  def guest_has_enough_money(guest)
    if guest.wallet >= @entry_fee
      return true
    else return false
    end
  end

  def add_entry_fee_to_till()
    @till += @entry_fee
  end

end
