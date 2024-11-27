# frozen_string_literal: true

# enhanced_output.rb
require 'io/console'

# Wrap text to fit the terminal width
def wrap_text(text, width)
  text.split("\n").map do |line|
    line.scan(/.{1,#{width}}(?:\s+|$)|\S+/).map(&:strip).join("\n")
  end.join("\n")
end

# Override puts
module Kernel
  alias original_puts puts
  def puts(*args)
    terminal_width = IO.console.winsize[1]
    args.each do |arg|
      if arg.is_a?(String)
        original_puts wrap_text(arg, terminal_width)
      else
        original_puts arg
      end
    end
  end
end
