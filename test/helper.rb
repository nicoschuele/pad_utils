require 'pad_utils'

# TODO: Use a function from PadUtils
def time_diff_sec(start, finish)
  result = ((finish - start)).to_i
  result == 0 ? 1 : result
end

# TODO: Add this method to PadUtils
def get_class_name(file)
  filename = File.basename file
  filename_no_ext = filename.gsub(".rb", "")
  class_name = PadUtils.camel_case(filename_no_ext)
  class_name
end
