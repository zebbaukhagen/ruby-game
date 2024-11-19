class InputManager

  def initialize(player, game_state)
    @player = player
    @game_state = game_state
    @global_commands = {
      "q"     => :quit,
      "quit"  => :quit,
      "north" => :move,
      "south" => :move,
      "east"  => :move,
      "west"  => :move,
      "look"  => :look
    }
  end

  def get_input
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
      puts "No such command known."
    end
  end

end