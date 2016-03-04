require 'securerandom'
module PadUtils

  # Converts a Ruby filename to a class name
  #
  # @param file [String] the file path and name. Must be a Ruby (`.rb`) file.
  # @return [String] the class name
  # @example
  #   PadUtils.filename_to_class("foo_bar.rb") # => FooBar
  def self.filename_to_classname(file)
    filename = File.basename file
    filename_no_ext = filename.gsub(".rb", "")
    class_name = PadUtils.camel_case(filename_no_ext)
    class_name
  end

  # Create a class from a filename.
  #
  # **Don't forget to `require_relative` the file**
  #
  # @param file [String] the file path and name. Must be a Ruby (`.rb`) file.
  # @return [Object] the class generated from the file
  # @example
  #   require_relative 'somepath/foo_bar'
  #   foobar = PadUtils.filename_to_class("somepath/foo_bar.rb")
  #   f = foobar.new
  def self.filename_to_class(file)
    class_name = PadUtils.filename_to_classname(file)
    Object.const_get(class_name)
  end

  # Generate UUID's.
  #
  # @param count [Int] how many uuid's to generate
  # @return [String, Array<String>] if only one uuid generated, returns a `String`. If not, an `Array`.
  # @example
  #   PadUtils.uuid(2) # => ["96b0a57c-d9ae-453f-b56f-3b154eb10cda", "332a0fa3-7b07-41e1-9fc8-ef804a377e4e"]
  def self.uuid(count = 1)
    if count == 1
      SecureRandom.uuid
    else
      result = []
      (1..count).each do
        result << SecureRandom.uuid
      end
      result
    end
  end

end
