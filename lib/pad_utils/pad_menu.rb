module PadUtils

  # Builds a `yes/no` cli menu.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param question [String] the question to ask
  # @param default [String] the default answer as `"y"` or `"n"` - (*default: `"y"`*)
  # @return [String] the answer as `"y"` or `"n"`
  # @example
  #   PadUtils.yes_no_menu("Is it cold outside?", default: "n")
  def self.yes_no_menu(question: "Question?", default: "y")
    default_answer = default == "y" ? "(Y/n)" : "(y/N)"
    STDOUT.print "#{question} #{default_answer}: "
    answer = STDIN.gets.chomp.strip.downcase
    answer = default if answer.length < 1
    answer == "y"
  rescue Exception => e
    PadUtils.log("Error in yes/no menu", e)
  end

  # Builds an open question menu.
  #
  # Will add `:` and a space after the question.
  #
  # @param question [String] the question to ask
  # @return [String] the answer to the question
  # @example
  #   PadUtils.question_menu("How are you?") # => 'All good'
  def self.question_menu(question)
    STDOUT.print "#{question}: "
    STDIN.gets.chomp.strip
  end

  # Builds a multiple choice menu.
  #
  # Will log errors using {PadUtils.log PadUtils.log}.
  #
  # @param question [String] the question to ask
  # @param choices [Hash] the possible choices
  # @param default [Symbol, nil] the default answer hash key. If nil, the last choice will be used.
  # @return [Symbol] the chosen option
  # @example
  #   options = {r: "red", b: "blue", g: "green"}
  #   PadUtils.choice_menu(question: "Which color?", choices: options, default: :b)
  def self.choice_menu(question: "Question?", choices: {}, default: nil)
    STDOUT.puts
    PadUtils.puts_c "- #{question}", :green
    default ||= choices.keys.last
    default = default.to_sym

    i = 0
    choices.each do |key, value|
      i += 1
      STDOUT.print "#{i}. #{value}"
      STDOUT.print " (default)" if key.to_s == default.to_s
      STDOUT.print "\n"
    end

    STDOUT.print "Your choice (1-#{choices.length}): "
    answer = STDIN.gets.chomp.strip.to_i
    STDOUT.puts
    if answer == 0 || answer > choices.length
      return default
    else
      return choices.keys[answer - 1].to_sym
    end
  rescue Exception => e
    PadUtils.log("Error in choice menu", e)
  end

end
