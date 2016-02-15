module PadUtils

  def self.convert_to_ruby_name(val)
    ""
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
