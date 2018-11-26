require 'sinatra'
require 'sinatra/reloader'

SECRET_NUMBER = rand(100)

get '/' do
  guess = params["guess"]
  message = check_guess(guess)
  puts message

  erb :index, :locals => {:message => message}
end

def check_guess(guess)
  guess_as_integer = guess.to_i
  message = ""

  if guess_as_integer == SECRET_NUMBER
    message << 'You got it right! THE SECRET NUMBER IS ' + SECRET_NUMBER.to_s
    return message
  elsif guess_as_integer > SECRET_NUMBER
    if guess_as_integer > SECRET_NUMBER + 5
      message << 'Way too high!'
      return message
    else
      message << 'Too high!'
      return message
    end
  elsif guess_as_integer < SECRET_NUMBER && guess_as_integer >= 1
    if guess_as_integer < SECRET_NUMBER - 5
      message << 'Way too low!'
      return message
    elsif
      message << 'Too low!'
      return message
    end
  else
    message << 'please make a guess'
    return message
  end

end
