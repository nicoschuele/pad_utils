require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "CopyAllFiles"

class CopyAllFilesTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    # Test code for CopyAllFiles goes here
    #
    # Runtime errors will be handled by a Rescue in the parent class
    #
    # You can add error messages to @errors
    #   example: @errors << "Some error message"
    # You can also add notes to @notes
    #   example: @notes << "Some note"
    @notes << "Execution directory: #{Dir.pwd}"
    PadUtils.copy_all_files "fixtures/source", "results/destination"
  end

  def cleanup
    # Add cleanup code here
  end

end
