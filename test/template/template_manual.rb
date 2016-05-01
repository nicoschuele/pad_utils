require_relative '../template/test'

class CLASS_TEST_NAME < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    # Test code for TEST_NAME goes here
    #
    # Runtime errors will be handled by a Rescue in the parent class
    #
    # You can add error messages to @errors
    #   example: @errors << "Some error message"
    # You can also add notes to @notes
    #   example: @notes << "Some note"
    puts "TEST_NAME not implemented"
  end

  def cleanup
    # Add cleanup code here
  end

end

# Test name
test_name = "TEST_NAME"
current_test = CLASS_TEST_NAME.new(test_name)
current_test.run
