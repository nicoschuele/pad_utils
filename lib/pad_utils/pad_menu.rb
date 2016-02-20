module PadUtils

  # Prompt user with a cli yes/no menu. Returns true or false.
  # question: the question to ask
  # default: the default answer
  def self.yes_no_menu(question: "Question?", default: "y")
    default_answer = default == "y" ? "(Y/n)" : "(y/N)"
    STDOUT.print "#{question} #{default_answer}: "
    answer = STDIN.gets.chomp.strip.downcase
    answer = default if answer.length < 1
    answer == "y"
    
  rescue Exception => e
    PadUtils.log("Error in yes/no menu", e)
  end

  # Prompt user with a cli open question menu. Returns a string.
  def self.question_menu(question)
    STDOUT.print "#{question}: "
    STDIN.gets.chomp.strip
  end

  # Prompt user with a multiple choice menu. Returns a symbol. Always!
  # question: the question to ask
  # choices: hash of choices (e.g. {b: "blue", r: "red"})
  # default: symbol representing the default value. If none provided, last
  #          value in choices hash will be used.
  def self.choice_menu(question: "Question?", choices: {}, default: nil)
    STDOUT.puts
    STDOUT.puts "- #{question}"
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
