# Hangman Game
class Hangman
  def initialize
    @secret = choose_secret.downcase
    @lives = 9
    @guess = []
    puts "Welcome to Hangman! You have #{@lives} lives to guess the secret word."
    generate_board
    puts @secret
    user_guess
  end

  def choose_secret
    secret = ''
    while secret.length >= 12 || secret.length <= 5
      File.foreach('word_bank.txt').each_with_index do |line, number|
        secret = line.strip if rand < 1.0 / (number + 1)
      end
    end
    secret
  end

  def generate_board
    @secret.each_char { print '_ ' }
  end

  def user_guess
    puts "\n"
    @guess = gets.chomp.to_s.downcase
    while @guess.length > 1 || @guess.empty?
      puts 'Invalid Guess, Try Again'
      @guess = gets.chomp.to_s.downcase
    end
    if @secret.include? @guess
      puts 'Your Guess Is Correct'
    else
      puts 'Your Guess Is Incorrect Try again'
      @turns -= 1
    end
  end

  def update_board

  end
end

game = Hangman.new
game