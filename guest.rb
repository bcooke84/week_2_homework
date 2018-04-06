class Guest

  attr_reader :name, :fave_song, :wallet

  def initialize(name, fave_song, wallet)
    @name = name
    @fave_song = fave_song
    @wallet = wallet
  end

  def guest_has_enough_money(room)
    if @wallet >= room.entry_fee
      return true
    else return false
    end
  end

end
