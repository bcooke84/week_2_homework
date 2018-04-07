require("minitest/autorun")
require("minitest/rg")

require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")
require_relative("../food.rb")
require_relative("../drink.rb")
require_relative("../karaoke_bar.rb")

class RoomTest < MiniTest::Test
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
    @guest5 = Guest.new("Ally", @song3, 55.00, 38, 30)
    @guestlist1 = [@guest1, @guest2, @guest3]
    @room1 = Room.new("Room 1", @playlist1, @guestlist1, 10)
    @room2 = Room.new("Room 2", @playlist1, @guestlist1, 3)
    @karaoke_bar1 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest3, @guest4], 15, 7.50, 50.00, @food, @drink)
    @karaoke_bar2 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [], 15, 7.50, 50.00, @food, @drink)
    @karaoke_bar3 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest1, @guest2, @guest3], 3, 7.50, 50.00, @food, @drink)
  end

  def test_get_room_id()
    assert_equal("Room 1", @room1.id)
  end

  def test_get_playlist()
    assert_equal(@playlist1, @room1.playlist)
  end

  def test_get_guest_list()
    assert_equal(@guestlist1, @room1.guest_list)
  end

  def test_get_capacity()
    assert_equal(10, @room1.capacity)
  end

  def test_add_song_to_room()
    @room1.add_song_to_playlist(@song4)
    assert_equal([@song1, @song2, @song3, @song4], @room1.playlist)
  end

  def test_remove_song_from_room()
    @room1.remove_song_from_playlist(@song3)
    assert_equal([@song1, @song2], @room1.playlist)
  end

  def test_check_guest_in_to_room()
    @room1.check_guest_check_in(@guest5)
    assert_equal([@guest1, @guest2, @guest3, @guest5], @room1.guest_list)
  end

  def test_check_guest_in_to_room__insufficient_capacity()
    assert_equal("Sorry, this room is full!", @room2.check_guest_check_in(@guest4))
  end

  def test_check_guest_out_of_room()
    @room1.check_guest_check_out(@guest3)
    assert_equal([@guest1, @guest2], @room1.guest_list)
  end

  def test_check_room_has_sufficient_capacity()
    assert_equal(true, @room1.check_capacity)
  end

  def test_check_room_has_insufficient_capacity()
    assert_equal(false, @room2.check_capacity)
  end

  def test_check_if_guest_favourite_song_is_present()
    assert_equal(true, @room1.check_guests_favourite_song(@guest5))
  end

  def test_check_if_guest_favourite_song_is_not_present()
    assert_equal(false, @room1.check_guests_favourite_song(@guest4))
  end

end
