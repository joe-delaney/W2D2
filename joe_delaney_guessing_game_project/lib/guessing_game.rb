class GuessingGame

    attr_reader :num_attempts

    def initialize(min, max)
        @min = min
        @max = max
        @num_attempts = 0
        @game_over = false
        @secret_num = rand(min..max)
    end

    def check_num(num)
        @num_attempts += 1
        if num == @secret_num
            @game_over = true 
            p "you win"
        elsif num > @secret_num
            p "too big"
        else
            p "too small"
        end
    end

    def ask_user
        p "enter a number"
        num = gets.chomp.to_i
        self.check_num(num)
    end

    def game_over?
        @game_over
    end
end
