require_relative "room"
require_relative "player"

rooms = load_rooms("rooms.yml")

starting_room = "dark_cave"

prompt = "Player > "

player = Player.new()
player.current_room = rooms[starting_room]

# main game loop
loop do
  player.view_current_room

  print prompt
  input = gets.chomp.downcase

  if input == "q"
    puts "quitting"
    return
  end

  if player.current_room.exits.key?(input.to_sym)
    next_room = player.current_room.exits[input.to_sym]
    puts "You exit to the #{input}"
    player.current_room = next_room
  else
    puts "That exit doesn't exist. Try another command."
  end

end

class InputManager
  input = nil

  def get_input
    input = gets.chomp.downcase
  end
end