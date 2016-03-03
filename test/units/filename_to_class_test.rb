require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "FilenameToClass"

class FilenameToClassTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    require_relative '../fixtures/foo_bar'
    foobar = PadUtils.filename_to_class("fixtures/foo_bar.rb")
    f = foobar.new
    result = f.say_hello
    if result != "Hello!"
      @errors << "Error in the method result"
    end
  end

  def cleanup
    # Add cleanup code here
  end

end
