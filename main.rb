# frozen_string_literal: true

require 'rainbow'

require_relative 'room'
require_relative 'player'
require_relative 'item'
require_relative 'input_manager'
require_relative 'item_manager'
require_relative 'custom_backtrace'

game_state = {
  quitting: false
}

starting_room = '00001'
rooms = load_rooms('rooms.yml')

PROMPT = Rainbow('Player > ').midnightblue

player = Player.new(rooms[starting_room])
input_manager = InputManager.new(player, game_state)
ItemManager.new(rooms)

# system('clear')
player.view_current_room(false)

# main game loop
until game_state[:quitting]
  print PROMPT
  input = input_manager.input
  input_manager.process_input(input)
end

puts 'Quitting. See you soon!'
