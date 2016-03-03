require 'pad_utils'

class Test

  attr_accessor :test_name, :errors, :notes, :result

  def initialize(test_name)
    @test_name = test_name
    @errors = []
    @notes = []
    @result = {name: test_name, errors: @errors.length}
  end

  def explain
    puts
    PadUtils.puts_c "Running: #{@test_name}...", :green
    puts
  end

  def raise_error(e)
    puts
    PadUtils.puts_c "Error in #{@test_name}: ", :error
    puts "#{e.message} (#{e.class.name})"
    stack = e.backtrace.inspect.split(",")
    stack.each do |s|
      puts "\t#{s}"
    end
    puts
  end

  def leave
    puts
    PadUtils.puts_c "Finished running: #{@test_name}", @errors.length < 1 ? :green : :error

    if @errors.length < 1
      PadUtils.puts_c "- 0 errors", :green
    else
      PadUtils.puts_c "- #{@errors.length} error(s):", :error
      @errors.each do |error|
        PadUtils.puts_c "--> #{error}"
      end
    end
    puts

    if @notes.length > 0
      PadUtils.puts_c "- #{@notes.length} note(s):", :green
      @notes.each do |note|
        PadUtils.puts_c "--> #{note}"
      end
      puts
    end

    PadUtils.puts_c "--------------------", :green
    puts
  end

  def run
    explain
    prepare
    runner
    cleanup
    leave
    @result[:errors] = @errors.length
    @result
  end

  def runner
    run_test
  rescue Exception => e
    @errors << "Error message: #{e.message}"
    raise_error(e)
  end

  def run_test
    PadUtils.puts_c "'#{@test_name} run_test method' not implemented!", :error
  end

  def prepare
    PadUtils.puts_c "'#{@test_name} prepare method' not implemented!", :error
  end

  def cleanup
    PadUtils.puts_c "'#{@test_name} cleanup method' not implemented!", :error
  end

end
