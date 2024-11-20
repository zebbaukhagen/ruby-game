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
    'look' => :look,
    'inventory' => :inventory,
    'inv' => :inventory,
    'take' => :get,
    'get' => :get,
    'drop' => :drop
  }.freeze

  def initialize(player, game_state)
    @player = player
    @game_state = game_state
    @global_commands = GLOBAL_COMMANDS
  end

  def input
    gets.chomp.downcase
  end

  # rubocop:disable Metric/MethodLength
  def process_input(input)
    # Destructure the command
    command, *args = input.split

    case @global_commands[command]
    when :quit
      @game_state[:quitting] = true
    when :move
      @player.attempt_move(input)
    when :look
      process_look(args)
    when :inventory
      @player.view_inventory
    when :get
      process_get_item(command, args)
    when :drop
      process_drop_item(args)
    else
      puts 'No such command known.'
    end
  end
  # rubocop:enable Metric/MethodLength

  def process_look(args)
    if args.empty?
      @player.view_current_room(true)
    elsif args.size == 1
      puts 'What are you trying to look at?'
    elsif args[0] == 'at'
      item_name = args[1..].join(' ')
      @player.inspect_item(item_name)
    else
      puts 'What are you trying to look at?'
    end
  end

  def process_get_item(verb, args)
    item_name = args.join(' ')
    return unless !args.empty? && !@player.get_item_from_current_room(item_name)

    puts "What are you trying to #{verb}?"
  end

  def process_drop_item(args)
    item_name = args.join(' ')
    @player.put_item_in_current_room(item_name)
  end
end
