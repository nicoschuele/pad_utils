require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "CreateDirectory"

class CreateDirectoryTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    PadUtils.puts_c "Current directory: #{Dir.pwd}", :blue
    PadUtils.create_directory("/Users/nico/workspace/ruby/pad_utils/test/results/new_dir/.")
    if !PadUtils.file_exist? "results/new_dir"
      @errors << "Directory not created"
    end
  end

  def cleanup
    PadUtils.delete_directory "results/new_dir" if PadUtils.file_exist? "results/new_dir"
  end

end
