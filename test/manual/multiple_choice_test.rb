require_relative 'manual'

choices = {b: "blue", r: "red", g: "green"}
answer = PadUtils.choice_menu(question: "Which color", choices: choices, default: :r)

puts "Answer is: #{answer}"
