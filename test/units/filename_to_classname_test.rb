require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "FilenameToClass"

class FilenameToClassnameTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    file = "fixtures/foo_bar.rb"
    klass = PadUtils.filename_to_classname(file)

    if klass != "FooBar"
      @errors << "Conversion was wrong."
    end
  end

  def cleanup
    # Add cleanup code here
  end

end
