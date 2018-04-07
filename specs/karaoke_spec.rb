require("minitest/autorun")
require("minitest/rg")

require_relative("../karaoke_bar.rb")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")
require_relative("../food.rb")
require_relative("../drink.rb")

class Karaoke_barTest < MiniTest::Test
  def setup()
    @drink1 = Drink.new("Beer", 4.00, 4)
    @drink2 = Drink.new("Wine", 5.00, 5)
    @drink3 = Drink.new("Cider", 3.00, 6)
    @drink = [@drink1, @drink2, @drink3]
    @food1 = Food.new("Crisps", 1.00, -2)
    @food2 = Food.new("Sandwich", 5.00, -5)
    @food3 = Food.new("Pizza", 10.00, -10)
    @food = [@food1, @food2, @food3]
    @song1 = Song.new("The Stone Roses", "Sally Cinnamon")
    @song2 = Song.new("Oasis", "Don't Look Back In Anger")
    @song3 = Song.new("The Courteeners", "Not Nineteen Forever")
    @song4 = Song.new("Blue", "Country House")
    @playlist1 = [@song1, @song2, @song3]
    @guest1 = Guest.new("Brian", @song1, 30.00, 33, 0)
    @guest2 = Guest.new("Upul", @song2, 40.00, 28, 10)
    @guest3 = Guest.new("Alistair", @song3, 5.00, 25, 0)
    @guest4 = Guest.new("Alan", @song4, 5.00, 17, 0)
    @guest5 = Guest.new("Ally", @song3, 55.00, 38, 30)
    @room1 = Room.new("Room 1", @playlist1, [], 10)
    @room2 = Room.new("Room 2", @playlist1, [], 3)
    @karaoke_bar1 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest3, @guest4], 15, 7.50, 50.00, @food, @drink)
    @karaoke_bar2 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [], 15, 7.50, 50.00, @food, @drink)
    @karaoke_bar3 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest1, @guest2, @guest3], 3, 7.50, 50.00, @food, @drink)
  end

  def test_get_bar_name()
    assert_equal("The Grumpy Git", @karaoke_bar1.name)
  end

  def test_get_entry_fee()
    assert_equal(7.50, @karaoke_bar1.entry_fee)
  end

  def test_get_capacity()
    assert_equal(15, @karaoke_bar1.capacity)
  end

  def test_get_rooms()
    assert_equal(2, @karaoke_bar1.rooms.count())
  end

  def test_get_number_of_guests()
    assert_equal(3, @karaoke_bar3.guests.count())
  end

  def test_admit_guest_to_bar()
    @karaoke_bar2.admit_guest_to_bar(@guest1)
    @karaoke_bar2.admit_guest_to_bar(@guest2)
    assert_equal([@guest1, @guest2], @karaoke_bar2.guests)
  end

  def test_get_till_total()
    @karaoke_bar1.admit_guest_to_bar(@guest1)
    @karaoke_bar1.admit_guest_to_bar(@guest2)
    assert_equal(65.00, @karaoke_bar1.till)
  end

  def test_check_guest_in_to_room__insufficient_capacity()
    assert_equal("There's no room at the inn!", @karaoke_bar3.admit_guest_to_bar(@guest3))
  end

  def test_guest_exits_bar()
    @karaoke_bar3.guest_exits_bar(@guest3)
    assert_equal([@guest1, @guest2], @karaoke_bar3.guests)
  end

  def test_check_bar_has_sufficient_capacity()
    assert_equal(true, @karaoke_bar1.check_capacity)
  end

  def test_check_bar_has_insufficient_capacity()
    assert_equal(false, @karaoke_bar3.check_capacity)
  end

  def test_check_guest_has_enough_money()
    assert_equal(true, @karaoke_bar1.guest_has_enough_money(@guest1))
  end

  def test_check_guest_does_not_have_enough_money()
    assert_equal(false, @karaoke_bar1.guest_has_enough_money(@guest4))
  end

  def test_check_room_has_enough_space_but_guest_has_insufficient_funds()
    assert_equal("There's a cash machine round the corner!", @karaoke_bar1.admit_guest_to_bar(@guest3))
  end

  def test_add_entry_fee_to_till()
    @karaoke_bar2.admit_guest_to_bar(@guest1)
    assert_equal(57.50, @karaoke_bar2.till)
  end

  def test_get_drinks_level
    assert_equal(3, @karaoke_bar1.bar_drink_count)
  end

  def test_get_food_levels
    assert_equal(3, @karaoke_bar1.bar_food_count)
  end

  def test_increase_money_in_till_when_drink_bought()
    @karaoke_bar1.sell_drink(@drink1)
    assert_equal(54, @karaoke_bar1.till)
  end

  def test_increase_money_in_till_when_food_bought()
    @karaoke_bar1.sell_food(@food3)
    assert_equal(60.00, @karaoke_bar1.till)
  end

  def test_that_drink_level_reduces_when_sold
    @karaoke_bar1.sell_drink_to_guest(@guest1, @drink1)
    assert_equal(2, @karaoke_bar1.bar_drink_count)
  end

  def test_that_food_level_reduces_when_sold
    @karaoke_bar1.sell_food_to_guest(@guest1, @food1)
    assert_equal(2, @karaoke_bar1.bar_food_count)
  end

  def test_drink_transaction()
    @karaoke_bar1.sell_drink_to_guest(@guest1, @drink1)
    assert_equal(26.00, @guest1.wallet)
    assert_equal(54.00, @karaoke_bar1.till)
    assert_equal(2, @karaoke_bar1.bar_drink_count)
  end

  def test_food_transaction()
    @karaoke_bar1.sell_food_to_guest(@guest1, @food3)
    assert_equal(20.00, @guest1.wallet)
    assert_equal(60.00, @karaoke_bar1.till)
    assert_equal(2, @karaoke_bar1.bar_food_count)
  end

  def test_guest_age()
    @karaoke_bar1.sell_drink_to_guest(@guest1, @drink1)
    assert_equal(33, @guest1.age_check)
  end

  def test_guest_age__underage()
    assert_equal("I wouldn't sell you a happy meal!", @karaoke_bar1.admit_guest_to_bar(@guest4))
  end

  def test_check_drunkenness_level__too_high()
    assert_equal("You don't gotta go home, but you can't stay here!", @karaoke_bar1.sell_drink_to_guest(@guest5, @drink1))
  end

end
