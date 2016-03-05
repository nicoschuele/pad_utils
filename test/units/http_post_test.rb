require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "HttpPost"

class HttpPostTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    # Test 1
    puts "Test 1:"
    url = "http://localhost:3000/services/v1/test/posting"
    body = { message: "test message" }
    PadUtils.puts_c "Sending: #{body}", :blue

    reply = PadUtils.http_post(url: url, body: body)
    PadUtils.puts_c "#{reply}", :blue

    if reply[:error] == "Response is not JSON"
      @notes << "Server is up, response not in JSON format"
    elsif !reply[:error].nil?
      @notes << "Error: #{reply[:error]}"
    else
      @errors << "#{reply}"
    end

    puts

    # Test 2
    puts "Test 2:"
    url = "http://localhost:3000/services/v1/test/posting_json"
    body = { message: "test message" }
    PadUtils.puts_c "Sending: #{body}", :blue

    reply = PadUtils.http_post(url: url, body: body)
    PadUtils.puts_c "#{reply}", :blue

    if reply[:message] == "test message"
      @notes << "Server up and replied"
    elsif !reply[:error].nil?
      @notes << "Error: #{reply[:error]}"
    else
      @errors << "#{reply}"
    end

    puts

    # Test 3
    puts "Test 3:"
    url = "http://localhost:3000/services/v1/test/posting_json"
    body = {}
    PadUtils.puts_c "Sending: #{body}", :blue

    reply = PadUtils.http_post(url: url, body: body)
    PadUtils.puts_c "#{reply}", :blue

    if reply[:message].nil? && reply[:error].nil?
      @notes << "Server up and replied with nil message"
    elsif !reply[:error].nil?
      @notes << "Error: #{reply[:error]}"
    else
      @errors << "#{reply}"
    end

    puts

    # Test 4
    puts "Test 4:"
    url = "http://localhost:3000/services/v1/test/generate_error"
    body = {divider: 0}
    PadUtils.puts_c "Sending: #{body}", :blue

    reply = PadUtils.http_post(url: url, body: body)
    PadUtils.puts_c "#{reply}", :blue

    @notes << "Error: #{reply[:error]}"


  end

  def cleanup
    # Add cleanup code here
  end

end
