require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "FilesRecursiveDelete"

class FilesRecursiveDeleteTest < Test

  def prepare
    PadUtils.copy_all_files("fixtures/source", "results/rec_delete")
  end

  def run_test
    PadUtils.delete_recursive("results/rec_delete", "sam*")
    if PadUtils.file_exist?("results/rec_delete/same.txt") || PadUtils.file_exist?("results/rec_delete/dir1/same.txt") || PadUtils.file_exist?("results/rec_delete/dir1/subdir1/same.txt")
      @errors << "Not all files deleted recursively"
    end
  end

  def cleanup
    # Add cleanup code here
  end

end
