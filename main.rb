require 'rainbow'

require_relative "room"
require_relative "player"
require_relative "inputManager"

rooms = load_rooms("rooms.yml")
starting_room = "dark_cave"

game_state = {
  quitting: false
}

PROMPT = Rainbow("Player > ").midnightblue

player = Player.new()
inputManager = InputManager.new(player, game_state)
player.current_room = rooms[starting_room]

system("clear")
player.view_current_room(false)

# main game loop
until game_state[:quitting] do
  print PROMPT
  input = inputManager.get_input
  inputManager.process_input(input)
end

puts "Quitting. See you soon!"