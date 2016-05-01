require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "ZipExtractZip"

class ZipExtractZipTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    PadUtils.extract_zip("fixtures/archive.zip", "results/extracted")

    if !PadUtils.file_exist?("results/extracted/penguin02.jpg") || !PadUtils.file_exist?("results/extracted/others/panda.jpg")
      @errors << "Seems files were not extracted"
    end
  end

  def cleanup
    # Add cleanup code here
  end

end
