#!/usr/bin/env ruby
require 'rubygems'
require 'bundler/setup'
require 'pad_utils'

start_time = Time.now
number_of_tests = 0
errors_list = []

puts

PadUtils.puts_c "Running tests...", :blue

Dir["units/*_test.rb"].each do |file|
  require_relative file

  class_name = PadUtils.filename_to_class(file)

  clazz = Object.const_get(class_name)
  c = clazz.new(class_name)
  errors = c.run

  if errors[:errors] > 0
    errors_list << errors
  end

  number_of_tests += 1
end

end_time = Time.now
interval = PadUtils.interval start_time, end_time, :seconds

PadUtils.puts_c "Finished running #{number_of_tests} tests in #{interval} seconds", :blue
if errors_list.length > 0
  PadUtils.puts_c "--> Failed (#{errors_list.length}): ", :error
  errors_list.each do |err|
    PadUtils.puts_c "- #{err[:name]}: #{err[:errors]} error(s)"
  end
else
  PadUtils.puts_c "--> 0 errors", :green
end
puts
