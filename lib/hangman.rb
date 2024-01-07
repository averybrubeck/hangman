require 'ruby2d'

class Hangman
  def initialize
    Window.set(title: 'Hangman', width: 840, height: 480, background: 'white')
    Image.new('background.png')
    create_man
    Window.show
  end

  def create_man
    @head = Circle.new(
      x: 200, y: 100,
      radius: 20,
      sectors: 32,
      color: 'red'
    )

    @body = Line.new(
      x1: 200, y1: 120,
      x2: 200, y2: 200,
      width: 5,
      color: 'red'
    )

    @left_leg = Line.new(
      x1: 200, y1: 200,
      x2: 180, y2: 240,
      width: 5,
      color: 'red'
    )

    @right_leg = Line.new(
      x1: 200, y1: 200,
      x2: 220, y2: 240,
      width: 5,
      color: 'red'
    )

    @left_arm = Line.new(
      x1: 200, y1: 140,
      x2: 180, y2: 180,
      width: 5,
      color: 'red'
    )

    @right_arm = Line.new(
      x1: 200, y1: 140,
      x2: 220, y2: 180,
      width: 5,
      color: 'red'
    )
  end
end
game = Hangman.new
game















def choose_secret
  secret = nil
  File.foreach('word_bank.txt').each_with_index do |line, number|
    secret = line if rand < 1.0 / (number + 1)
  end
  if secret.length >= 12 || secret.length <= 5
    File.foreach('word_bank.txt').each_with_index do |line, number|
      secret = line if rand < 1.0 / (number + 1)
    end
  end
  puts secret
end