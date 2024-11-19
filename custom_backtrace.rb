# frozen_string_literal: true

require 'backtrace_cleaner'
require 'English'

# Method to clean backtrace
def clean_backtrace(backtrace)
  # Set up a new BacktraceCleaner inside the method
  backtrace_cleaner = BacktraceCleaner.new

  # Add a filter to remove the specific file path you want
  backtrace_cleaner.add_filter do |line|
    line.gsub('/Users/zebbaukhagen/Leaf & Limb Dropbox/Zebulun Baukhagen/Mac/Documents/Programming/', '')
  end

  # Return the cleaned backtrace
  backtrace_cleaner.clean(backtrace)
end

# Capture uncaught exceptions at the end of the program
at_exit do
  if $ERROR_INFO
    # If an uncaught exception occurred, clean its backtrace
    $ERROR_INFO.set_backtrace(clean_backtrace($ERROR_INFO.backtrace))
    # Print the cleaned exception
    puts $ERROR_INFO.message
    puts $ERROR_INFO.backtrace.join("\n")
  end
end
