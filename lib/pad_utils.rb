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

  # Entry point for the executable. Not really useful.
  def self.main(arg)
    puts
    puts "PadUtils v.#{PadUtils::VERSION}"
    puts
    puts "Part of the Padstone app builder (http://padstone.io)"
    puts
    puts "Copyright 2016 - Nico Schuele"
    puts "Licensed under the Apache License, Version 2.0"
    puts
  end
end
