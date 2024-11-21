# frozen_string_literal: true

require 'yaml'

# spawns items into world
class ItemManager
  def initialize(rooms)
    @rooms = rooms
    @item_defs = {}
    load_items('item_descriptions.yml')
    spawn_items
  end

  def spawn_items
    cup = spawn(:cup)
    @rooms['00001'].add_item(cup) if cup
  end

  def spawn(type)
    Item.new(type.to_s, @item_defs[type][:short_description], @item_defs[type][:long_description])
  end

  def load_items(file_path)
    data = YAML.safe_load(File.read(file_path), symbolize_names: true)
    puts 'Item data loaded' if data && data[:items]
    return unless data && data[:items] # Safeguard against malformed YAML

    data[:items].each do |id, info|
      @item_defs[id] = info
    end
  end
end
