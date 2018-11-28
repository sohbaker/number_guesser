class PlayWebGuesser

  def initialize(guess, secret_number)
    @guess_as_integer = guess.to_i
    @secret_number = secret_number
  end

  def way_too_high_or_way_too_low
    if @guess_as_integer > @secret_number + 5
      return 'Way too high!'
    elsif @guess_as_integer < @secret_number - 5
      return 'Way too low!'
    end
  end

  def within_five_numbers
    if @guess_as_integer > @secret_number
      return 'A little too high...'
    elsif @guess_as_integer < @secret_number
      return 'A little too low...'
    end
  end

  def correct
    return "You got it right! THE SECRET NUMBER IS #{@secret_number}"
  end
end
