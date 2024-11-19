# frozen_string_literal: true

require 'yaml'

# Represents a room in the game, with various attributes and exits.
class Room
  attr_accessor :short_description, :exits

  def initialize(short_description, long_description)
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

def load_rooms(file_path)
  data = YAML.load_file(file_path)
  rooms = {}

  # create rooms without exits
  data['rooms'].each do |id, info|
    room = Room.new(info['short_description'], info['long_description'])
    info['exits'].each do |direction, neighbor_id|
      room.exits[direction.to_sym] = rooms[neighbor_id]
    end
    rooms[id] = room
  end

  rooms
end
