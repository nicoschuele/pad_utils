module PadUtils

  # Convert a string into a proper Ruby name.
  # For example, 'app_name' will be converted to 'AppName' 
  def self.convert_to_ruby_name(value)
    if value.scan(/\_|\-/).size > 0
      value.split(/\_|\-/).map(&:capitalize).join
    else
      value.slice(0,1).capitalize + value.slice(1..-1)
    end
  end
  
  # Convert a string to only alphanumeric and underscores
  def self.sanitize(value)
    value.tr('^A-Za-z0-9', '_')
  end

  # Replace text within a file.
  # old_text can be a regex or a string
  def self.replace(file, old_text, new_text)
    text_update = File.read(file)
    text_update = text_update.gsub(old_text, new_text)

    File.open(file, "w") { |f| f.write(text_update) }
  rescue Exception => e
    puts e
  end

end
