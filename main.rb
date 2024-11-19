# frozen_string_literal: true

require 'rainbow'

require_relative 'room'
require_relative 'player'
require_relative 'item'
require_relative 'input_manager'
require_relative 'custom_backtrace'

cup = Item.new('cup', 'a plain brown cup', 'A plain brown cup, made of clay sits here silently.')

starting_room = 'dark_cave'
rooms = load_rooms('rooms.yml')
rooms[starting_room].add_item(cup)

game_state = {
  quitting: false
}

PROMPT = Rainbow('Player > ').midnightblue

player = Player.new(rooms[starting_room])
input_manager = InputManager.new(player, game_state)

# system('clear')
player.view_current_room(false)

# main game loop
until game_state[:quitting]
  print PROMPT
  input = input_manager.input
  input_manager.process_input(input)
end

puts 'Quitting. See you soon!'
