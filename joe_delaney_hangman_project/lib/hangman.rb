class Hangman
  DICTIONARY = ["cat", "dog", "bootcamp", "pizza"]

  def self.random_word
    DICTIONARY.sample
  end

  attr_reader :guess_word, :attempted_chars, :remaining_incorrect_guesses

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, '_')
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def already_attempted?(char)
    return true if @attempted_chars.include?(char)
    return false
  end

  def get_matching_indices(char)
    new_arr = []
    @secret_word.each_char.with_index {|c, idx| new_arr << idx if c == char}
    new_arr
  end

  def fill_indices(char, indices)
    indices.each {|idx| @guess_word[idx] = char}
  end

  def try_guess(char)
    if already_attempted?(char)
      p 'that has already been attempted'
      return false
    else
      @attempted_chars << char
      temp = get_matching_indices(char)
      if temp.length > 0
        fill_indices(char, temp)
      else
        @remaining_incorrect_guesses -= 1
      end
      return true
    end
  end

  def ask_user_for_guess
    p "Enter a char:"
    char = gets.chomp
    try_guess(char)
  end

  def win?
    @secret_word.each_char.with_index do |char, idx|
      return false if char != @guess_word[idx]
    end
    p "WIN"
    return true
  end  

  def lose?
    if @remaining_incorrect_guesses == 0
      p "LOSE"
      return true 
    else
      return false
    end
  end


  def game_over?
    if win? || lose?
      p @secret_word
      return true 
    else 
      return false 
    end
  end
end
