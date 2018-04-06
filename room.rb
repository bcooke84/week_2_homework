class Room

  attr_reader :id, :playlist, :guest_list, :capacity, :entry_fee

  def initialize(id, playlist, guest_list, capacity, entry_fee)
    @id = id
    @playlist = playlist
    @guest_list = guest_list
    @capacity = capacity
    @entry_fee = entry_fee
  end

  def add_song_to_playlist(song)
    @playlist.push(song)
  end

  def remove_song_from_playlist(song)
    @playlist.delete(song)
  end

  def check_guest_check_in(guest)
    if check_capacity == true
      @guest_list.push(guest)
    else p "There's no room at the inn!"
    end
  end

  def check_guest_check_out(guest)
    @guest_list.delete(guest)
  end

  def check_capacity()
    if @guest_list.count <= @capacity - 1
      return true
    else return false
    end
  end

  def check_guest_has_enough_money(guest)
    # guest.guest_has_enough_money(room)
    if guest.wallet >= @entry_fee
      return true
    else return false
    end
  end


end
