module PadUtils

  # Converts a Ruby filename to a class name
  #
  # @param file [String] the file path and name. Must be a Ruby (`.rb`) file.
  # @return [String] the class name
  # @example
  #   PadUtils.filename_to_class("foo_bar.rb") # => FooBar
  def self.filename_to_class(file)
    filename = File.basename file
    filename_no_ext = filename.gsub(".rb", "")
    class_name = PadUtils.camel_case(filename_no_ext)
    class_name
  end

end
