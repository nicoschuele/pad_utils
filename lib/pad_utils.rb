require_relative "pad_utils/version"
require_relative "pad_utils/pad_files"
require_relative "pad_utils/pad_text"
require_relative "pad_utils/pad_time"
require_relative "pad_utils/pad_logger"
require_relative "pad_utils/pad_menu"

module PadUtils
  # TODO: Add a cli coloring feature
  
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
