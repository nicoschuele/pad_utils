require 'rubygems'
require 'bundler/setup'
require 'pad_utils'

Dir["manual/*_test.rb"].each do |file|
  puts
  PadUtils.puts_c "Running: #{file}", :green
  require_relative file
  PadUtils.puts_c "Completed: #{file}", :green
end
