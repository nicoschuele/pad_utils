require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "DownloadFile"

class DownloadFileTest < Test

  def prepare
    @url = "http://localhost:3000/services/v1/test/download"
    PadUtils.create_directory("results/download/.")
  end

  def run_test
    reply = PadUtils.http_get_file(@url, "results/download/rick_morty.jpg")

    PadUtils.puts_c reply, :blue

    if reply == "Server unreachable"
      @notes << "Server is not reachable"
    elsif !PadUtils.file_exist?("results/download/rick_morty.jpg")
      @errors << "File not downloaded"
    end

  end

  def cleanup
    PadUtils.delete_directory("results/download") if PadUtils.file_exist?("results/download")
  end

end
