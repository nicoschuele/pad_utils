require_relative "pad_utils/version"
require_relative "pad_utils/pad_files"
require_relative "pad_utils/pad_text"
require_relative "pad_utils/pad_time"
require_relative "pad_utils/pad_logger"
require_relative "pad_utils/pad_menu"
require_relative "pad_utils/pad_json"
require_relative "pad_utils/pad_color"
require_relative "pad_utils/pad_code"
require_relative "pad_utils/pad_security"
require_relative "pad_utils/pad_http"

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
    elsif arg[0] == '-e'
      if arg[1].nil? || arg[2].nil?
        puts
        PadUtils.puts_c "padutils -e <word to encrypt> <encryption key>"
      else
        PadUtils.puts_c PadUtils.encrypt content: arg[1], key: arg[2]
      end
    elsif arg[0] == '-d'
      if arg[1].nil? || arg[2].nil?
        puts
        PadUtils.puts_c "padutils -d <string to decrypt> <encryption key>"
      else
        PadUtils.puts_c PadUtils.decrypt content: arg[1], key: arg[2]
      end
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
