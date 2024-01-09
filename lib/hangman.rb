# Hangman Game
class Hangman
  def initialize
    @secret = choose_secret.downcase
    @turns = 9
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
      update_board
    else
      puts 'Your Guess Is Incorrect Try again'
      @turns -= 1
      hang_the_man
    end
  end

  def update_board
    updated_board = ''
    @secret.each_char do |c|
      updated_board += @guess.include?(c) ? c + ' ' : '_ '
    end
    puts updated_board.strip
  end

  def hang_the_man
    case @turns
    when 8
      print 'The head has been hung'
    when 7
      print 'The body has been hung'
    when 6
      print 'The left leg has been hung'
    when 5
      print 'The right leg has been hung'
    when 4
      print 'The leg arm has been hung'
    when 3
      print 'The right arm has been hung'
    when 2
      print 'The face has been drawn'
    when 1
      print 'The man is almost dead, better hurry!'
    when @turns.zero?
      print 'The man is dead'
    end
  end
end

game = Hangman.new
game