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
require_relative "pad_utils/pad_compression"

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
    elsif arg[0] == '--rsa'
      if arg[1].nil? || arg[2].nil?
        puts
        PadUtils.puts_c "padutils --rsa <private | public> <path/to/key.pem>", :blue
      else
        generate_rsa arg[1], arg[2]
      end
    else
      help
    end
  end

  def self.generate_rsa(type, path)
    if type == "private"
      PadUtils.generate_rsa_private_key path: path
    end

    if type == "public"
      PadUtils.generate_rsa_public_key private_key: path, path: "public.pem"
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
