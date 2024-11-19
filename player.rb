# frozen_string_literal: true

# Represents the player in the game, with access to the current room.
class Player
  attr_accessor :current_room

  def view_current_room(long_look)
    current_room.view_room(long_look)
  end

  def attempt_move(direction)
    direction_sym = direction.to_sym
    if current_room.exits.key?(direction_sym)
      puts "You exit to the #{direction}."
      @current_room = current_room.exits[direction_sym]
      view_current_room(false)
    else
      puts 'There is no exit in that direction.'
    end
  end
end
