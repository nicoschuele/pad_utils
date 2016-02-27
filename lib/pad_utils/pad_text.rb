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

  # Converts a CamelCase string to an underscore string.
  #
  # Taken from the Rails {http://api.rubyonrails.org/classes/ActiveSupport/Inflector.html#method-i-underscore Inflector}
  # class.
  #
  # @param val [String] the CamelCase string to underscore
  # @return [String] the under_score string
  # @example
  #   PadUtils.underscore("CamelCase") # => camel_case
  def self.underscore(val)
    word = val.dup
    word.gsub!(/::/, '/')
    word.gsub!(/([A-Z]+)([A-Z][a-z])/,'\1_\2')
    word.gsub!(/([a-z\d])([A-Z])/,'\1_\2')
    word.tr!("-", "_")
    word.downcase!
    word
  end

  # Sanitizes a string.
  #
  # Will only allow alphanumeric characters and underscores.
  #
  # @param value [String] the string to sanitize
  # @return [String] the sanitized string
  # @example
  #   PadUtils.sanitize("Abc Def *34*#yXz") # => 'Abc_Def__34__yXz'
  def self.sanitize(value)
    value.tr('^A-Za-z0-9', '_')
  end

  # Replaces text in a file.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param file [String] the file path and name
  # @param old_text [String, Regexp] the text to find as a string or regex
  # @param new_text [String] the new text
  # @return [Void] nothing
  # @example
  #   PadUtils.replace_in_file("example.txt", /some_text/, "new text")
  def self.replace_in_file(file, old_text, new_text)
    text_update = PadUtils.get_file_content(file)
    text_update = text_update.gsub(old_text, new_text)

    PadUtils.write_to_file(file, text_update)
  rescue Exception => e
    PadUtils.log("Error replacing #{old_text} in #{file} with #{new_text}", e)
  end

  # TODO: A method to get the value of an option. E.g. get :foo from Config.Bar = :foo inside a file.
  # TODO: A method to set the value of an option in a file. Change the value if it exists, create it if it doesn't.

  # Replaces a line in a file containing a specific value.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param value [String] the value to search for in a line
  # @param in_file [String] the file path and name where to search
  # @param new_value [String] the value replacing the line
  # @return [Void] nothing
  # @example
  #   PadUtils.replace_line_containing("Config.port", in_file: "config.rb", new_value: "Config.port = 232")
  def self.replace_line_containing(value, in_file: nil, new_value: nil)
    content = PadUtils.get_file_content(in_file)
    new_content = ""
    content.each_line do |line|
      if line.include? value
        new_content << "#{new_value}\n"
      else
        new_content << line
      end
    end
    PadUtils.write_to_file(in_file, new_content)
  rescue Exception => e
    PadUtils.log("Error in replace_line_containing", e)
  end

  # Inserts text before the first occurence of a string.
  #
  # Can be used on a string or on a file.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param original [String] the original file path and name *or* the original string
  # @param tag [String] the string to find
  # @param text [String] the string to insert
  # @param is_file [Boolean] `true` if `original` is a file, `false` if it is a string
  # @return [String] the new content
  # @example
  #   PadUtils.insert_before_first(original: "file.txt", tag: "end", text: "# hello!")
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

  # Inserts text before the last occurence of a string.
  #
  # Can be used on a string or on a file.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param original [String] the original file path and name *or* the original string
  # @param tag [String] the string to find
  # @param text [String] the string to insert
  # @param is_file [Boolean] `true` if `original` is a file, `false` if it is a string
  # @return [String] the new content
  # @example
  #   PadUtils.insert_before_last(original: "file.txt", tag: "end", text: "# hello!")
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

  # Inserts text after the first occurence of a string.
  #
  # Can be used on a string or on a file.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param original [String] the original file path and name *or* the original string
  # @param tag [String] the string to find
  # @param text [String] the string to insert
  # @param is_file [Boolean] `true` if `original` is a file, `false` if it is a string
  # @return [String] the new content
  # @example
  #   PadUtils.insert_after_first(original: "file.txt", tag: "end", text: "# hello!")
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

  # Inserts text after the last occurence of a string.
  #
  # Can be used on a string or on a file.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param original [String] the original file path and name *or* the original string
  # @param tag [String] the string to find
  # @param text [String] the string to insert
  # @param is_file [Boolean] `true` if `original` is a file, `false` if it is a string
  # @return [String] the new content
  # @example
  #   PadUtils.insert_after_last(original: "file.txt", tag: "end", text: "# hello!")
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
