require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "DecryptCli"

class DecryptCliTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    PadUtils.puts_c "Should display decrypted hello:", :blue
    PadUtils.main ["-d", "pHgZ%2FApEmcrf1ZuO1bK82g%3D%3D%0A__09c26329e9644ee2a2a9b194a5e5128a", "dev_key"]    
  end

  def cleanup
    # Add cleanup code here
  end

end
