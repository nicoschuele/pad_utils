require 'httparty'
require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "HttpGet"

class HttpGetTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    # Test 1
    puts "Test 1:"
    url = "http://localhost:3000/services/v1/test/index"
    reply = PadUtils.http_get_plain(url)

    PadUtils.puts_c "Calling: #{url}", :blue
    PadUtils.puts_c "Reply: #{reply}", :blue
    PadUtils.puts_c "Reply class: #{reply.class}", :blue

    if reply == "Hello"
      @notes << "Response received"
    elsif reply == "Server unreachable"
      @notes << "#{reply}"
    else
      @errors << "Something went wrong"
    end

    puts

    # Test 2
    puts "Test 2:"
    url = "http://localhost:3000/services/v1/test/index_json"
    reply = PadUtils.http_get(url)

    PadUtils.puts_c "Calling: #{url}", :blue
    PadUtils.puts_c "Reply: #{reply}", :blue
    PadUtils.puts_c "Reply class: #{reply.class}", :blue

    if reply[:message] == "Hello"
      @notes << "Response received"
    elsif !reply[:error].nil?
      @notes << "#{reply[:error]}"
    else
      @errors << "Something went wrong"
    end

    puts

    # Test 3
    puts "Test 3:"
    url = "http://localhost:3000/services/v1/test/index_error"
    reply = PadUtils.http_get(url)

    PadUtils.puts_c "Calling: #{url}", :blue
    PadUtils.puts_c "Reply: #{reply}", :blue
    PadUtils.puts_c "Reply class: #{reply.class}", :blue

    if reply[:message] == "Hello"
      @notes << "Response received"
    elsif !reply[:error].nil?
      @notes << "#{reply[:error]}"
    else
      @errors << "Something went wrong"
    end

    puts

  end

  def cleanup
    # Add cleanup code here
  end

end
