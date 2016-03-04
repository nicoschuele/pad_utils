require_relative "pad_utils/version"
require_relative "pad_utils/pad_files"
require_relative "pad_utils/pad_text"
require_relative "pad_utils/pad_time"
require_relative "pad_utils/pad_logger"
require_relative "pad_utils/pad_menu"
require_relative "pad_utils/pad_json"
require_relative "pad_utils/pad_color"
require_relative "pad_utils/pad_code"

# Main namespace for PadUtils.
#
# Each method is implemented as a module method. Prefix them with PadUtils to call them.
# @example
#   PadUtils.some_method(param)
module PadUtils

  # Entry point for the executable.
  def self.main(arg)
    if arg[0] == '-u'
      PadUtils.puts_c PadUtils.uuid, :blue
    else
      help
    end
  end

  # Display version of PadUtils if no switches are passed.
  def self.help
    puts
    PadUtils.puts_c "PadUtils v.#{PadUtils::VERSION}", :green
    puts
    puts "Part of the Padstone app builder (http://padstone.io)"
    puts
    puts "Copyright 2016 - Nico Schuele"
    puts "Licensed under the Apache License, Version 2.0"
    puts
  end
end
