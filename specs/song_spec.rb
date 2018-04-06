require("minitest/autorun")
require("minitest/rg")

require_relative("../song.rb")

class SongTest < MiniTest::Test

  def setup()
    @song1 = Song.new("The Stone Roses", "Sally Cinnamon")
    @song2 = Song.new("Oasis", "Don't Look Back In Anger")
    @song3 = Song.new("The Courteeners", "Not Nineteen Forever")
  end

  def test_get_song_artist()
    assert_equal("Oasis", @song2.artist)
  end

  def test_get_song_title()
    assert_equal("Sally Cinnamon", @song1.title)
  end

  

end
