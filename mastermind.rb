class Mastermind
  def initialize
    puts "A new game of Mastermind has been created"
    @code = 4.times.map { rand(6) + 1 }
    @filled_dot = "\u2022"
    @hollow_dot = "\u25e6"
  end

  def start_game
    @turn = 1
    while @turn < 11
      get_input
      puts "Turn: #{@turn}"
      p @code
      p @guess
      give_clues
      break if game_over?
      @turn += 1
    end
  end

  def game_over?
    win? || lose?
  end

  def win?
    if @clues.all?(@filled_dot)
      puts "You won!"
      true
    end
  end

  def lose?
    if @turn == 10
      puts "You lost!"
      true
    end
  end

  def get_input
    puts "Please choose four numbers between 1-6: "
    input = gets.chomp
    get_input unless valid_input?(input)
    @guess = convert_input(input)
  end

  def valid_input?(input)
    if input.length > 4
      puts "The number you entered is too long."
      false
    elsif input.length < 4
      puts "The number your entered is too short."
      false
    elsif input.match?(/\D/)
      puts "Please enter numbers only."
      false
    elsif input.match?(/[^1-6]/)
      puts "Please only enter numbers from 1-6."
      false
    else
      puts 'Accepted'
      true
    end
  end

  def convert_input(input)
    return input.split('').map { |num| num.to_i }
  end

  def give_clues
    @clues = [' ', ' ', ' ', ' ']
    code_temp = []
    guess_temp = []

    @guess.each_with_index do |number, index|
      if @guess[index] == @code[index]
        @clues.unshift(@filled_dot).pop
      else
        code_temp << @code[index]
        guess_temp << @guess[index]
      end
    end

    guess_temp.uniq.each do |guess|
      if code_temp.uniq.include?(guess)
        @clues.unshift(@hollow_dot).pop
      end
    end

    puts "[#{@clues[0]}][#{@clues[1]}]"
    puts "[#{@clues[2]}][#{@clues[3]}]"
  end
end

mastermind = Mastermind.new
mastermind.start_game