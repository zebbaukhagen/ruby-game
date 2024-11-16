require "yaml"

class Room
  attr_accessor :description, :exits

  def initialize(description)
    @description = description
    @exits = {}
  end

  def view_room
    puts @description
    puts "This room has the following exits: #{@exits.keys.join(', ')}"
  end
end

def load_rooms(file_path)
  data = YAML.load_file(file_path)
  rooms = {}

  # create rooms without exits
  data['rooms'].each do |id, info|
    rooms[id] = Room.new(info['description'])
  end

  # link exits
  data['rooms'].each do |id, info|
    room = rooms[id]
    info['exits'].each do |direction, neighbor_id|
      room.exits[direction.to_sym] = rooms[neighbor_id]
    end
  end
  rooms
end