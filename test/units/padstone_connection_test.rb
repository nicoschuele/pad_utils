require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "PadstoneConnection"

class PadstoneConnectionTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    result = PadUtils::Padstone::connection_status
    prod_continue = true
    dev_continue = true

    if result[:dev].nil?
      @errors << "Dev is nil"
      dev_continue = false
    end

    if dev_continue
      case result[:dev]
      when :up
        @notes << "Dev is up"
      when :down
        @notes << "Dev is down"
      else
        @errors << "Unknown dev status"
      end
    end


    if result[:prod].nil?
      @errors << "Prod is nil"
      prod_continue = false
    end

    if prod_continue
      case result[:prod]
      when :up
        @notes << "Prod is up"
      when :down
        @notes << "Prod is down"
      else
        @errors << "Unknown prod status"
      end

    end

  end

  def cleanup
    # Add cleanup code here
  end

end
