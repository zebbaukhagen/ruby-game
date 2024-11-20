# frozen_string_literal: true

require 'yaml'

# Represents a room in the game, with various attributes and exits.
class Room
  attr_accessor :name, :short_description, :exits, :room_inv

  def initialize(name, short_description, long_description)
    @name = name
    @short_description = short_description
    @long_description = long_description
    @exits = {}
    @room_inv = []
  end

  def view_room(long_look)
    items_names = []
    items_names << room_inv.map(&:short_description)
    description = long_look ? @long_description : @short_description
    puts Rainbow(description).whitesmoke
    puts "These items sit nearby: #{items_names.join(', ')}" unless @room_inv.empty?
    puts "This room has the following exits: #{@exits.keys.join(', ')}"
  end

  def add_item(item)
    @room_inv << item
  end

  def return_item!(item_name)
    item = @room_inv.find { |element| element.short_name == item_name }
    return unless item

    @room_inv.delete(item)
  end

  def find_item_by_name(item_name)
    @room_inv.find { |item| item.short_name == item_name }
  end
end

# rubocop:disable Style/CombinableLoops, Metrics/MethodLength, Metrics/AbcSize
# Loads rooms from .yml file into hash. Unfortunately needs two loops to
# reference the neighbor_id data from the rooms object.
def load_rooms(file_path)
  data = YAML.load_file(file_path)
  rooms = {}

  data['rooms'].each do |id, info|
    room = Room.new(info['name'], info['short_description'], info['long_description'])
    rooms[id] = room
  end

  data['rooms'].each do |id, info|
    room = rooms[id]
    info['exits'].each do |direction, neighbor_id|
      room.exits[direction.to_sym] = rooms[neighbor_id]
    end
  end
  rooms
end
# rubocop:enable Style/CombinableLoops, Metrics/MethodLength, Metrics/AbcSize
