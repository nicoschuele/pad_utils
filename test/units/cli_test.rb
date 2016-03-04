require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "Cli"

class CliTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    PadUtils.puts_c "Should display the 'splash':", :blue

    PadUtils.main []
    puts

    PadUtils.puts_c "Should display a uuid:", :blue

    PadUtils.main ["-u"]
  end

  def cleanup
    # Add cleanup code here
  end

end
