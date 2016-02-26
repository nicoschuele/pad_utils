module PadUtils

  # Module variable holding the log path. By default,
  # logs will go in ~/pad_logs/
  @@log_path = "#{ENV["HOME"]}/pad_logs"

  # Module variable holding the log file. By default,
  # logs will go in @@log_path/logs.txt
  @@log_file = "logs.txt"

  # Sets a different log path.
  #
  # @param val [String] the path to the directory
  # @return [String] the log directory path
  # @example
  #   PadUtils.set_log_path("path/directory") # => 'path/directory'
  def self.set_log_path(val)
    @@log_path = val
  end

  # Sets a different log file.
  #
  # @param val [String] the log file name
  # @return [String] the log file name
  # @example
  #   PadUtils.set_log_file("my_logs.txt") # => 'my_logs.txt'
  def self.set_log_file(val)
    @@log_file = val
  end

  # Logs a message.
  #
  # @note If using the method within a rescue block, pass the exception from
  #   `rescue Exception => e`
  #
  # @param message [String] the message to log
  # @param e [Exception] the raised exception
  # @return [Void] nothing
  # @example
  #   def faulty_method
  #     a = 0
  #     b = 3
  #     c = b / a
  #   rescue Exception => e
  #     PadUtils.log("Something bad happened!", e)
  #   end
  def self.log(message, e = nil)
    # Create the log directory if it doesn't exist
    PadUtils.create_directory(@@log_path)

    # Add a timestamp to the message
    message = "#{PadUtils.time_to_stamp(Time.now)}: #{message}"

    # If an error is added, add its inner message to the message
    # as well as the whole stack
    if e != nil
      message = "#{message}\n\tError: #{e.message} (#{e.class.name})"
      stack = e.backtrace.inspect.split(",")
      stack.each do |s|
        message = "#{message}\n\t\t#{s}"
      end
      message = "#{message}\n"
    end

    # Adds the message to the log file
    PadUtils.append_to_file("#{@@log_path}/#{@@log_file}", message)
  end

end
