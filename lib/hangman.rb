require 'yaml'

# Hangman Game
class Hangman
  def initialize
    puts 'New Game or Load Game? n or l'
    answer = gets.chomp.to_s.downcase
    if answer == 'n'
      new_game
    elsif answer == 'l'
      load_game('output.yaml')
    else
      puts 'invalid input, try again'
    end
  end

  def new_game
    @secret = choose_secret.downcase
    @turns = 9
    @guess = []
    @guessed_chars = []
    @updated_board = ''
    puts "Welcome to Hangman! You have #{@turns} lives to guess the secret word."
    puts @secret
  end

  def to_yaml
    yaml_content = YAML.dump({
        secret: @secret,
        turns: @turns,
        guessed_chars: @guessed_chars,
        board: @updated_board
    })
    File.write('output.yaml', yaml_content)
  end

  def load_game(path)
    data = File.read(path)
    loaded_data = YAML.load(data)

    @secret = loaded_data[:secret]
    @turns = loaded_data[:turns]
    @guessed_chars = loaded_data[:guessed_chars]
    @updated_board = loaded_data[:board]
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
    @guess = gets.chomp.to_s.downcase
    while @guess.length > 1 || @guess.empty?
      puts 'Invalid Guess, Try Again'
      @guess = gets.chomp.to_s.downcase
    end

    @guessed_chars << @guess

    if @secret.include? @guess
      puts 'Your Guess Is Correct'
      to_yaml
    else
      puts 'Your Guess Is Incorrect Try again'
      @turns -= 1
      hang_the_man
    end
  end

  def update_board
    @updated_board = ''
    @secret.each_char do |c|
      @updated_board += @guessed_chars.include?(c) ? c + ' ' : '_ '
    end
    puts "The secret is #{@updated_board.strip}"
    guessed = @guessed_chars.to_s
    puts "Your guessed letters are #{guessed}"
  end

  def hang_the_man
    case @turns
    when 8
      puts 'The head has been hung'
    when 7
      puts 'The body has been hung'
    when 6
      puts 'The left leg has been hung'
    when 5
      puts 'The right leg has been hung'
    when 4
      puts 'The leg arm has been hung'
    when 3
      puts 'The right arm has been hung'
    when 2
      puts 'The face has been drawn'
    when 1
      puts 'The man is almost dead, better hurry!'
    when 0
      puts 'The man is dead'
    end
  end

  def play_game
    loop do
      user_guess
      update_board
      to_yaml
      load_game('output.yaml')
      if !@updated_board.include?('_')
        puts 'You saved the man! Congrats!'
        break
      elsif @turns.zero?
        puts 'You lose!'
        break
      end
     end
  end
end

game = Hangman.new
game.play_game


