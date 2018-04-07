class Guest

  attr_reader :name, :fave_song, :wallet

  def initialize(name, fave_song, wallet)
    @name = name
    @fave_song = fave_song
    @wallet = wallet
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

end
