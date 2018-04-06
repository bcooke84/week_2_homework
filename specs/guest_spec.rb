require("minitest/autorun")
require("minitest/rg")

require_relative("../guest.rb")
require_relative("../song.rb")
require_relative("../room.rb")

class GuestTest < MiniTest::Test
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
    @guestlist1 = [@guest1, @guest2, @guest3]
    @room1 = Room.new("Room 1", @playlist1, @guestlist1, 10, 7.50)
    @room2 = Room.new("Room 2", @playlist1, @guestlist1, 3, 7.50)
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
    assert_equal(true, @guest1.guest_has_enough_money(@room1))
  end

  def test_guest_does_not_have_enough_money()
    assert_equal(false, @guest4.guest_has_enough_money(@room1))
  end

end
