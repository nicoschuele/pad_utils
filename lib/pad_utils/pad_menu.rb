module PadUtils

  # Prompts user with a cli yes/no menu. Returns true or false.
  # question: the question to ask
  # default: the default answer
  def self.yes_no_menu(question: "question?", default: "y")
    default_answer = default == "y" ? "(Y/n)" : "(y/N)"
    STDOUT.print "#{question} #{default_answer}: "
    answer = STDIN.gets.chomp.strip.downcase
    answer = default if answer.length < 1
    answer == "y"
  rescue Exception => e
    PadUtils.log("Error in yes/no menu", e)
  end

  # Prompts user with a cli open question menu. Returns a string.
  def self.question_menu(question)
    STDOUT.print "#{question}: "
    STDIN.gets.chomp.strip
  end

end
