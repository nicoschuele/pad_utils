require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "PadstoneConnected"

class PadstoneConnectedTest < Test

  def prepare
    ENV['PADSTONE'] = "development"
  end

  def run_test
    connected = PadUtils::Padstone.connected?
    if connected
      @notes << "Dev server connected"
    else
      @notes << "Dev server not reachable"
    end
  end

  def cleanup
    ENV['PADSTONE'] = nil
  end

end
