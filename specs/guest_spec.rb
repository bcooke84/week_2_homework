require("minitest/autorun")
require("minitest/rg")

require_relative("../guest.rb")
require_relative("../song.rb")
require_relative("../room.rb")
require_relative("../karaoke_bar.rb")
require_relative("../food.rb")
require_relative("../drink.rb")

class GuestTest < MiniTest::Test
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
    @guest3 = Guest.new("Alistair", @song3, 50.00, 25, 0)
    @guest4 = Guest.new("Alan", @song4, 5.00, 17, 0)
    @guestlist1 = [@guest1, @guest2, @guest3]
    @room1 = Room.new("Room 1", @playlist1, @guestlist1, 10)
    @room2 = Room.new("Room 2", @playlist1, @guestlist1, 3)
    @karaoke_bar1 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest3, @guest4], 15, 7.50, 50.00, @food, @drink)
    @karaoke_bar2 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [], 15, 7.50, 50.00, @food, @drink)
    @karaoke_bar3 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest1, @guest2, @guest3], 3, 7.50, 50.00, @food, @drink)
  end

  def test_get_guest_name()
    assert_equal("Brian", @guest1.name)
  end

  def test_get_fave_song()
    assert_equal(@song1, @guest1.fave_song)
  end

  def test_get_wallet_amount()
    assert_equal(30.00, @guest1.wallet)
  end

  def test_guest_has_enough_money()
    assert_equal(true, @guest1.guest_has_enough_money(@karaoke_bar1))
  end

  def test_guest_does_not_have_enough_money()
    assert_equal(false, @guest4.guest_has_enough_money(@karaoke_bar1))
  end

  def test_guest_wallet_amount_has_reduced__drink
    @guest1.buy_drink(@drink1)
    assert_equal(26.00, @guest1.wallet)
  end

  def test_guest_wallet_amount_has_reduced__food
    @guest1.buy_food(@food3)
    assert_equal(20.00, @guest1.wallet)
  end

  def test_guest_drunkenness_level
    assert_equal(0, @guest1.drunkenness_level)
  end

  def test_guest_drunkenness_level__after_drink
    @guest1.buy_drink(@drink2)
    assert_equal(5, @guest1.drunkenness_level)
  end

  def test_guest_drunkenness_level__after_food_item
    @guest2.buy_food(@food1)
    assert_equal(8, @guest2.drunkenness_level)
  end

end
