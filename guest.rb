class Guest

  attr_reader :name, :fave_song, :wallet, :age, :drunkenness_level

  def initialize(name, fave_song, wallet, age, drunkenness_level)
    @name = name
    @fave_song = fave_song
    @wallet = wallet
    @age = age
    @drunkenness_level = drunkenness_level
  end

  def guest_has_enough_money(karaoke_bar)
    if @wallet >= karaoke_bar.entry_fee
      return true
    else return false
    end
  end

  def pay_entry_fee(fee)
    @wallet -= fee
  end

  def buy_drink(drink)
    @wallet -= drink.price
    @drunkenness_level += drink.alcohol_level
  end

  def buy_food(food)
    @wallet -= food.price
    @drunkenness_level += food.rejuvenation_level
  end

  def age_check()
    return @age
  end

end
