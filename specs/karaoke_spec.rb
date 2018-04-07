require("minitest/autorun")
require("minitest/rg")

require_relative("../karaoke_bar.rb")
require_relative("../room.rb")
require_relative("../song.rb")
require_relative("../guest.rb")


class Karaoke_barTest < MiniTest::Test
  def setup()
    @song1 = Song.new("The Stone Roses", "Sally Cinnamon")
    @song2 = Song.new("Oasis", "Don't Look Back In Anger")
    @song3 = Song.new("The Courteeners", "Not Nineteen Forever")
    @song4 = Song.new("Blue", "Country House")
    @playlist1 = [@song1, @song2, @song3]
    @guest1 = Guest.new("Brian", @song1, 30.00)
    @guest2 = Guest.new("Upul", @song2, 40.00)
    @guest3 = Guest.new("Alistair", @song3, 50.00)
    @guest4 = Guest.new("Alan", @song4, 5.00)
    @guest5 = Guest.new("Ally", @song3, 55.00)
    @room1 = Room.new("Room 1", @playlist1, [], 10)
    @room2 = Room.new("Room 2", @playlist1, [], 3)
    @karaoke_bar1 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest3, @guest4], 15, 7.50, 50.00)
    @karaoke_bar2 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [], 15, 7.50, 50.00)
    @karaoke_bar3 = Karaoke_bar.new("The Grumpy Git", [@room1, @room2], [@guest1, @guest2, @guest3], 3, 7.50, 50.00)
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
    assert_equal("There's no room at the inn!", @karaoke_bar3.admit_guest_to_bar(@guest5))
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
    assert_equal("There's a cash machine round the corner!", @karaoke_bar1.admit_guest_to_bar(@guest4))
  end

  def test_add_entry_fee_to_till()
    @karaoke_bar2.admit_guest_to_bar(@guest1)
    assert_equal(57.50, @karaoke_bar2.till)
  end

end
