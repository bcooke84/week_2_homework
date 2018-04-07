class Room

  attr_reader :id, :playlist, :guest_list, :capacity

  def initialize(id, playlist, guest_list, capacity)
    @id = id
    @playlist = playlist
    @guest_list = guest_list
    @capacity = capacity
  end

  def add_song_to_playlist(song)
    @playlist.push(song)
  end

  def remove_song_from_playlist(song)
    @playlist.delete(song)
  end

  def check_guest_check_in(guest)
    if check_capacity == false
      p "Sorry, this room is full!"
    else @guest_list.push(guest)
      p "Whoop, they have my favourite tune!" if check_guests_favourite_song(guest) == true
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

  def guest_has_enough_money(guest)
    if guest.wallet >= @entry_fee
      return true
    else return false
    end
  end

  def check_guests_favourite_song(guest)
    for song in @playlist
      return true if guest.fave_song() == song
    end
  else
    return false
  end


end
