
















def choose_secret
  secret = " "
  while secret.length >= 12 || secret.length <= 5
    File.foreach('word_bank.txt').each_with_index do |line, number|
      secret = line if rand < 1.0 / (number + 1)
    end
  end
  puts secret
end

choose_secret