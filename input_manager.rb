# frozen_string_literal: true

# Handles input from the player and delegates to appropriate classes.
class InputManager
  GLOBAL_COMMANDS = {
    'q' => :quit,
    'quit' => :quit,
    'north' => :move,
    'south' => :move,
    'east' => :move,
    'west' => :move,
    'look' => :look
  }.freeze

  def initialize(player, game_state)
    @player = player
    @game_state = game_state
    @global_commands = GLOBAL_COMMANDS
  end

  def input
    gets.chomp.downcase
  end

  def process_input(input)
    case @global_commands[input]
    when :quit
      @game_state[:quitting] = true
    when :move
      @player.attempt_move(input)
    when :look
      @player.view_current_room(true)
    else
      puts 'No such command known.'
    end
  end
end
