# frozen_string_literal: true

require 'yaml'

# Represents a room in the game, with various attributes and exits.
class Room
  attr_accessor :name, :short_description, :exits

  def initialize(name, short_description, long_description)
    @name = name
    @short_description = short_description
    @long_description = long_description
    @exits = {}
  end

  def view_room(long_look)
    description = long_look ? @long_description : @short_description
    puts Rainbow(description).whitesmoke
    puts "This room has the following exits: #{@exits.keys.join(', ')}"
  end
end

# rubocop:disable Style/CombinableLoops, Metrics/MethodLength, Metrics/AbcSize
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
