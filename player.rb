# frozen_string_literal: true

require_relative 'enhanced_output'

# Represents the player in the game, with access to the current room.
class Player
  attr_accessor :current_room, :inventory

  def initialize(starting_room)
    @current_room = starting_room
    @inventory = []
  end

  def view_current_room(long_look)
    current_room.view_room(long_look)
  end

  def view_inventory
    item_names = @inventory.map(&:short_name)
    puts "You are holding: #{item_names.join(', ')}"
  end

  def add_item(item)
    @inventory << item
  end

  def get_item_from_current_room(item_name)
    item = @current_room.return_item!(item_name)
    return item unless item

    puts "You pick up the #{item.short_name}."
    add_item(item)
  end

  def put_item_in_current_room(item_name)
    item = find_item_by_name(item_name)
    return unless item

    puts "You set the #{item.short_name} down."
    @current_room.add_item(item)
    remove_item(item)
  end

  def remove_item(item)
    @inventory.delete(item)
  end

  def inspect_item(item_name)
    item = @current_room.find_item_by_name(item_name) || find_item_by_name(item_name)
    if item
      puts item.long_description
    else
      puts 'What are you trying to look at?'
    end
  end

  def find_item_by_name(item_name)
    @inventory.find { |item| item.short_name == item_name }
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
