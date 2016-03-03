require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "Sample"

class SampleTest < Test

  def prepare
    puts "I'm preparing..."
  end

  def run_test
    puts "Running the test..."
  end

  def cleanup
    puts "Cleaning up after the test..."
  end

end
