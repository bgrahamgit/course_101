
VALID_CHOICES = %w(r s p l k)

winning_plays = {
  "r" => ['s', 'l'],
  "s" => ['p', 'l'],
  "p" => ['r', 'k'],
  "l" => ['k', 'p'],
  "k" => ['r', 's']
}

def prompt(message)
  puts "=> #{message}"
end

def valid_integer(num)
  num.to_i.to_s == num
end

loop do
  total_rounds = nil
  round = 1
  wins = 0

  prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!")

  loop do
    prompt("How many rounds would you like to play?")
    total_rounds = gets.chomp

    if valid_integer(total_rounds)
      total_rounds = total_rounds.to_i
      break
    end

    prompt("Please enter a valid integer")
  end

  loop do
    user_choice = ''

    loop do
      puts "==== Round #{round} ===="
      choice_prompt = <<-MSG
        Choose one of the following:
        'R' for rock
        'P' for paper
        'S' for scissors
        'L' for lizard
        'k' for Spock
      MSG

      prompt(choice_prompt)
      user_choice = gets.chomp.downcase

      break if VALID_CHOICES.include?(user_choice)
      prompt("=> Invalid choice.")
    end

    computer_choice = VALID_CHOICES.sample

    puts "=> You played #{user_choice}, the computer played #{computer_choice}"

    if user_choice == computer_choice
      prompt("It's a tie! Replay the round.")
      next
    elsif winning_plays[user_choice].include?(computer_choice)
      prompt("You win!")
      wins += 1
    else
      prompt("You lost!")
    end

    round += 1
    break if round > total_rounds
  end

  puts "=> You won #{wins} out of #{total_rounds} rounds."
  puts "=============================================="

  prompt("Enter 'Y' if you would like to play again:")
  play_again = gets.chomp.downcase
  break unless play_again.start_with?('y')
end

prompt("Thanks for playing!")
