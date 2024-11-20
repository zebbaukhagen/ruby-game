# frozen_string_literal: true

require 'yaml'

require_relative 'item'

# spawns items into world
class ItemManager
  def initialize(rooms)
    @rooms = rooms
    @item_defs = {}
    load_items('item_descriptions.yml')
  end

  def spawn_items
    cup = Item.new(@item_defs[:cup], @item_defs[:cup][:short_description], @item_defs[:cup][:long_description])

    @rooms['cozy_room'].add_item(cup)
  end

  def load_items(file_path)
    data = YAML.load_file(file_path)
    data.each do |id, info|
      @item_defs[id] = info
    end
  end
end
