require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "ReplaceKeysInFile"

class ReplaceKeysInFileTest < Test

  def prepare
    PadUtils.copy_file("fixtures/sample_file.rb", "results/replaced.rb")
  end

  def run_test
    values = [
      {key: /REPLACE_ME/, value: "REPLACED"},
      {key: /REPLACE_ALSO/, value: "REPLACED AS WELL"}
    ]
    PadUtils.replace_keys_in_file("results/replaced.rb", values)
  end

  def cleanup
    # Add cleanup code here
  end

end
