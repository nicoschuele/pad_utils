# require 'pad_utils'
# require_relative '../template/test'
#
# # Test name
# test_name = "HttpGet"
#
# class HttpGetTest < Test
#
#   def prepare
#     # Add test preparation here
#   end
#
#   def run_test
#     # Test 1
#     puts "Test 1:"
#     url = "http://localhost:3000/services/v1/test/index"
#     reply = PadUtils.http_get(url)
#
#     PadUtils.puts_c "Calling: #{url}", :blue
#     PadUtils.puts_c "Reply: #{reply}", :blue
#
#     if reply == "Hello"
#       @notes << "Response received"
#     else
#       @error << "Something went wrong"
#     end
#
#     puts
#
#     # Test 2
#
#   end
#
#   def cleanup
#     # Add cleanup code here
#   end
#
# end
