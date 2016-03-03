require "time"

module PadUtils

  # Returns a string timestamp.
  #
  # Format `YYYYMMDDHHmmss` will be used.
  #
  # @param val [Time] the Time object to convert
  # @return [String] the timestamp
  # @example
  #   PadUtils.time_to_stamp(Time.now) # => 20160227160122
  def self.time_to_stamp(val)
    val.strftime("%Y%m%d%H%M%S")
  end

  # Returns a Time object from a string timestamp.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param val [String] a string formatted as `YYYYMMDDHHmmss`
  # @return [Time] the Time object
  # @example
  #   PadUtils.stamp_to_time("20160227160122")
  def self.stamp_to_time(val)
    Time.parse "#{val[0..3]}-#{val[4..5]}-#{val[6..7]} #{val[8..9]}:#{val[10..11]}:#{val[12..13]}"
  rescue Exception => e
    PadUtils.log("Error in stamp_to_time", e)
  end

  # Returns a readable string timestamp.
  #
  # Format `YYYY-MM-DD HH:mm:ss` will be used.
  #
  # @param val [Time] the Time object to convert
  # @return [String] the readable timestamp
  def self.time_to_readable_stamp(val)
    val.strftime("%Y-%m-%d %H:%M:%S")
  end

  # Returns a Time object from a readable timestamp.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param val [String] the readable timestamp formatted as `YYYY-MM-DD HH:mm:ss`
  # @return [Time] the Time object
  def self.readable_stamp_to_time(val)
    Time.parse val
  rescue Exception => e
    PadUtils.log("Error in readable_stamp_to_time", e)
  end

  # Returns the interval of time between two Time objects.
  #
  # @param start_time [Time] the starting time
  # @param end_time [Time] the ending time
  # @param unit [Symbol] the unit to use from `:seconds`, `:minutes`, `:hours`, `:days`
  # @return [Float] the interval, rounded at 3 digits
  # @example
  #   start = Time.now - 30
  #   finish = Time.now
  #   PadUtils.interval(start, finish, :minutes)  # => 0.5
  def self.interval(start_time, end_time, unit = :seconds)
    result = -1
    inter = (end_time - start_time)

    if unit == :minutes
      result = inter / 60.0
    elsif unit == :hours
      result = (inter / 60) / 60
    elsif unit == :days
      result = ((inter / 60) / 60) / 24
    else
      result = inter
    end

    result.round(3)

  end

end
