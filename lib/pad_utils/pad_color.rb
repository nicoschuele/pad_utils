module PadUtils

  # Colorizes the cli output.
  #
  # Colors have aliases:
  #
  # * `:blue` => `:note`, `:emphasis`
  # * `:red` => `:error`, `:danger`, `:alert`, `:failure`
  # * `:green` => `:correct`, `:success`, `:info`
  #
  # @param text [String] the string to output
  # @param highlight [Symbol, nil] the color to be used (`:red`, `:green`, `:blue`, `nil`)
  # @param wrap [Boolean] if `true`, will wrap the text at 80 characters
  # @return [Void] nothing
  # @example
  #   PadUtils.puts_c "Hello World", :green
  def self.puts_c(text, highlight = nil, wrap = true)
    # Set color codes
    red = 31
    green = 32
    blue = 36

    # Set color to use
    current_color = nil
    case highlight
    when :red, :error, :danger, :alert, :failure
      current_color = red
    when :green, :correct, :success, :info
      current_color = green
    when :blue, :note, :emphasis
      current_color = blue
    else
      current_color = nil
    end

    # Wrap the text
    if wrap
      text = text.gsub(/\n/, ' ').gsub(/(.{1,#{79}})(\s+|$)/, "\\1\n").strip
    end

    # Just display text if no color chosen. Else, colorize it.
    if current_color == nil
      STDOUT.puts text
    else
      STDOUT.puts "\e[#{current_color}m#{text}\e[0m"
    end

  end

end
