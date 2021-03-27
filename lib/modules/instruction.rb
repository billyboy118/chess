# frozen_string_literal: false

# module to start the game off
module Instructions
  def self.short_instructions
    puts "\nTo move a piece, first you need to select it by typing in the coordinates,".red
    puts 'then you need to type in the coordinates where you wish to move it to. As long'.red
    puts 'one letter and one number is typed for both the computer will figure out the rest.'.red
    instruction_prompt
  end

  def self.instruction_prompt
    prompt = TTY::Prompt.new
    greeting = puts "\nAre you happy or would you like further instructions?"
    choices = ["No, I don't need the instructions", 'Yes, I would like further instruction (not currently available)']
    full_instruction if prompt.select(greeting, choices).include? 'Yes'
  end

  def self.full_instruction
    puts 'These will be coming shortly'
  end
end
