# frozen_string_literal: true

# Base class for all items in the game.
class Item
  attr_reader :item_id, :short_name, :short_description, :long_description

  def initialize(short_name, short_description, long_description)
    @short_name = short_name
    @short_description = short_description
    @long_description = long_description
  end
end
