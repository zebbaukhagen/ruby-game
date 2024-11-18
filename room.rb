require 'yaml'

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
    rooms[id] = Room.new(info['short_description'], info['long_description'])
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