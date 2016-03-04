require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "Uuid"

class UuidTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    iteration = 10000

    # Check unique
    uuid_array = []
    (1..iteration).each do
      uuid_array << PadUtils.uuid
    end
    unique = uuid_array.uniq
    if unique.length != uuid_array.length
      @errors << "There are duplicate values"
    end

    # Check multiple
    uuid_array = PadUtils.uuid(iteration)
    if uuid_array.length != iteration
      @errors << "Array doesn't contain #{iteration} uuids"
    end
    unique = uuid_array.uniq
    if unique.length != uuid_array.length
      @errors << "Multiple generation contains duplicate values"
    end
  end

  def cleanup
    # Add cleanup code here
  end

end
