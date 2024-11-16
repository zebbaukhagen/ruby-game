class Player
  attr_accessor :current_room

  def initialize()
  end

  def view_current_room()
    current_room.view_room
  end
end