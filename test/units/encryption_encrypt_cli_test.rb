require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "EncryptionEncryptCli"

class EncryptionEncryptCliTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    PadUtils.puts_c "Should display encrypted hello:", :blue
    PadUtils.main ["-e", "hello", "dev_key"]
  end

  def cleanup
    # Add cleanup code here
  end

end
