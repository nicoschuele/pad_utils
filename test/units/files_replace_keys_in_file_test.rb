require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "FilesReplaceKeysInFile"

class FilesReplaceKeysInFileTest < Test

  def prepare
    PadUtils.copy_file("fixtures/sample_file.rb", "results/replaced.rb")
  end

  def run_test
    values = [
      {key: /REPLACE_ME/, value: "REPLACED"},
      {key: /REPLACE_ALSO/, value: "CHANGED AS WELL"}
    ]

    PadUtils.replace_keys_in_file("results/replaced.rb", values)

    replaced_count = PadUtils.get_file_content("results/replaced.rb").scan(/REPLACED/).length

    changed_count = PadUtils.get_file_content("results/replaced.rb").scan(/CHANGED AS WELL/).length

    if changed_count != 2 || replaced_count != 2
      @errors << "Replaced count is wrong."
    end

  end

  def cleanup
    PadUtils.delete_file("results/replaced.rb")
  end

end
