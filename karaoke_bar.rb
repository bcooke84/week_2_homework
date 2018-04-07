class Karaoke_bar

  attr_reader :name, :rooms, :guests, :capacity, :entry_fee, :till, :food, :drink

  def initialize(name, rooms, guests, capacity, entry_fee, till, food, drink)
    @name = name
    @rooms = rooms
    @guests = guests
    @capacity = capacity
    @entry_fee = entry_fee
    @till = till
    @food = food
    @drink = drink
  end

  def admit_guest_to_bar(guest)
    if guest.drunkenness_level >= 30
      p "Not tonight!"
    elsif guest.age_check < 18
      p "I wouldn't sell you a happy meal!"
    elsif check_capacity == false
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

  def sell_drink(drink)
    @drink.include?(drink)
    @till += drink.price
    @drink.delete(drink)
  end

  def sell_food(food)
    @food.include?(food)
    @till += food.price
    @food.delete(food)
  end

  def sell_drink_to_guest(guest, drink)
    if guest.drunkenness_level <30
      sell_drink(drink)
      guest.buy_drink(drink)
    else guest_exits_bar(guest)
      return p "You don't gotta go home, but you can't stay here!"
    end
  end

  def sell_food_to_guest(guest, food)
    sell_food(food)
    guest.buy_food(food)
  end

  def bar_drink_count()
    return @drink.count()
  end

  def bar_food_count()
    return @food.count()
  end

end
