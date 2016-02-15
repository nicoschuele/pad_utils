module PadUtils

  # Return a string timestamp with the format: YYYYMMDDHHmmss
  def self.time_to_stamp(val)
    val.strftime("%Y%m%d%H%M%S")
  end

  # Return a Time object from a timestamp with the format: YYYYMMDDHHmmss
  def self.stamp_to_time(val)
    Time.parse "#{val[0..3]}-#{val[4..5]}-#{val[6..7]} #{val[8..9]}:#{val[10..11]}:#{val[12..13]}"
  end

end
