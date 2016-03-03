require 'pad_utils'
require_relative '../template/test'

# Test name
test_name = "TimeDifference"

class TimeDifferenceTest < Test

  def prepare
    # Add test preparation here
  end

  def run_test
    # Normal case, secs, mins
    start_time = Time.now - 1*60
    end_time = Time.now

    interval_in_secs = PadUtils.interval(start_time, end_time)
    interval_in_mins = PadUtils.interval(start_time, end_time, :minutes)

    if interval_in_secs != 60
      @errors << "Interval in seconds is wrong"
    end

    if interval_in_mins != 1
      @errors << "Interval in minutes is wrong"
    end

    # Normal case, hours, days
    start_time = Time.now - 1*60*60*24
    end_time = Time.now

    interval_in_hours = PadUtils.interval(start_time, end_time, :hours)
    interval_in_days = PadUtils.interval(start_time, end_time, :days)

    if interval_in_hours != 24
      @errors << "Interval in hours is wrong"
    end

    if interval_in_days != 1
      @errors << "Interval in days is wrong"
    end

    # Below limit case
    start_time = Time.now - 1*30
    end_time = Time.now
    interval_in_mins = PadUtils.interval(start_time, end_time, :minutes)
    interval_in_hours = PadUtils.interval(start_time, end_time, :hours)
    interval_in_days = PadUtils.interval(start_time, end_time, :days)

    if interval_in_mins != 0.5
      @errors << "below limit in mins is wrong"
    end

    if interval_in_hours != 0.008
      @errors << "below limit in hours is wrong"
    end

    if interval_in_days != 0.0
      @errors << "below limit in days is wrong"
    end

  end

  def cleanup
    # Add cleanup code here
  end

end
