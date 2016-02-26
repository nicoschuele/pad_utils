module PadUtils

  # Converts a string to a Rubified name.
  #
  # @deprecated Use {PadUtils.camel_case PadUtils.camel_case} instead as it will
  #   properly sanitize the string as well.
  #
  # @param value [String] the string to rubify
  # @return [String] the rubified string
  # @example
  #   s = "hello_you"
  #   PadUtils.convert_to_ruby_name(s) # => 'HelloYou'
  def self.convert_to_ruby_name(value)
    if value.scan(/\_|\-/).size > 0
      value.split(/\_|\-/).map(&:capitalize).join
    else
      value.slice(0,1).capitalize + value.slice(1..-1)
    end
  end

  # Converts a string to a CamelCase.
  #
  # @note The string will first be sanitized using {PadUtils.sanitize PadUtils.sanitize}.
  #
  # @param value [String] the string to CamelCase
  # @return [String] the CamelCased string
  # @example
  #   s = "hello_you"
  #   s2 = "hello you"
  #   s3 = "hello   $you#"
  #   PadUtils.convert_to_ruby_name(s) # => 'HelloYou'
  #   PadUtils.convert_to_ruby_name(s2) # => 'HelloYou'
  #   PadUtils.convert_to_ruby_name(s3) # => 'HelloYou'
  def self.camel_case(value)
    value = self.sanitize(value)
    if value.scan(/\_|\-/).size > 0
      value.split(/\_|\-/).map(&:capitalize).join
    else
      value.slice(0,1).capitalize + value.slice(1..-1)
    end
  end

  # Convert a CamelCase word to an underscored one, e.g. camel_case
  # Taken from the Rails Inflector class.
  def self.underscore(val)
    word = val.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  # Convert a string to only alphanumeric and underscores
  def self.sanitize(value)
    value.tr('^A-Za-z0-9', '_')
  end

  # Replace text within a file.
  # old_text can be a regex or a string
  def self.replace_in_file(file, old_text, new_text)
    text_update = PadUtils.get_file_content(file)
    text_update = text_update.gsub(old_text, new_text)

    PadUtils.write_to_file(file, text_update)
  rescue Exception => e
    PadUtils.log("Error replacing #{old_text} in #{file} with #{new_text}", e)
  end

  # Insert text in a string or a file before the first occurence of a string.
  # original: the original string or filename
  # tag: occurence of string to find
  # text: string to insert
  # is_file: say if original is a file (default: true) or a string
  def self.insert_before_first(original: nil, tag: nil, text: nil, is_file: true)
    # The new text will be consolidated in content
    content = ""

    # If coming from a file, read original into content
    if is_file
      content = PadUtils.get_file_content(original)
    else
      content = original
    end

    # Iterate line by line. If a position is found, insert the text
    # and set found to true to prevent further insertions
    found = false
    new_content = ""
    content.each_line do |line|
      position = line.index(/#{tag}/)
      if position && !found
        new_content += "#{text}#{line}"
        found = true
      else
        new_content += line
      end
    end

    # If coming from a file, write result in same file. If not,
    # simply return content
    if is_file
      PadUtils.write_to_file(original, new_content)
      return new_content
    else
      return new_content
    end

  rescue Exception => e
    PadUtils.log("Error in insert_before_first", e)
  end

  # Insert text in a string or a file before the last occurence of a string.
  # original: the original string or filename
  # tag: occurence of string to find
  # text: string to insert
  # is_file: say if original is a file (default: true) or a string
  def self.insert_before_last(original: nil, tag: nil, text: nil, is_file: true)
    # The new text will be consolidated in content
    content = ""

    # If coming from a file, read original into content
    if is_file
      content = PadUtils.get_file_content(original)
    else
      content = original
    end

    # Find the position of tag in the string array and insert the text
    positions = content.enum_for(:scan, /#{tag}/).map { Regexp.last_match.begin(0) }
    content[positions.last - 1] = "#{text}"

    # If coming from a file, write result in same file. If not,
    # simply return content
    if is_file
      PadUtils.write_to_file(original, content)
      return content
    else
      return content
    end

  rescue Exception => e
    PadUtils.log("Error in insert_before_last", e)
  end

  # Insert text in a string or a file after the first occurence of a string.
  # original: the original string or filename
  # tag: occurence of string to find
  # text: string to insert
  # is_file: say if original is a file (default: true) or a string
  def self.insert_after_first(original: nil, tag: nil, text: nil, is_file: true)
    # The new text will be consolidated in content
    content = ""

    # If coming from a file, read original into content
    if is_file
      content = PadUtils.get_file_content(original)
    else
      content = original
    end

    # Iterate line by line. If a position is found, insert the text
    # and set found to true to prevent further insertions
    found = false
    new_content = ""
    content.each_line do |line|
      position = line.index(/#{tag}/)
      if position && !found
        new_content += "#{line}#{text}"
        found = true
      else
        new_content += line
      end
    end

    # If coming from a file, write result in same file. If not,
    # simply return content
    if is_file
      PadUtils.write_to_file(original, new_content)
      return new_content
    else
      return new_content
    end

  rescue Exception => e
    PadUtils.log("Error in insert_after_first", e)
  end

  # Insert text in a string or a file after the last occurence of a string.
  # original: the original string or filename
  # tag: occurence of string to find
  # text: string to insert
  # is_file: say if original is a file (default: true) or a string
  def self.insert_after_last(original: nil, tag: nil, text: nil, is_file: true)
    # The new text will be consolidated in content
    content = ""

    # If coming from a file, read original into content
    if is_file
      content = PadUtils.get_file_content(original)
    else
      content = original
    end

    # Find the position of tag in the string array and insert the text
    positions = content.enum_for(:scan, /#{tag}/).map { Regexp.last_match.begin(0) }
    content[positions.last + tag.length] = "#{text}"

    # If coming from a file, write result in same file. If not,
    # simply return content
    if is_file
      PadUtils.write_to_file(original, content)
      return content
    else
      return content
    end

  rescue Exception => e
    PadUtils.log("Error in insert_after_last", e)
  end

end
