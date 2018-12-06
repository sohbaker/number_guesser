require 'sinatra'
require 'sinatra/reloader'
require '../web_guesser/play_web_guesser.rb'

SECRET_NUMBER = rand(1..100)

get '/' do
  correct_colour = "yellow"
  if params["play"]
    redirect to("/play_game")
  end
  erb :index, :locals => {:correct_colour => correct_colour}
end

get '/play_game' do
  guess = params["guess"]
  correct_colour = "yellow"

  if guess.to_i >= 1
    message = check_guess(guess)
    if message.include? "Way"
      correct_colour = "red"
      puts message +  "\nMake another guess!"
    elsif message.include? "A little"
      correct_colour = "orange"
      puts message +  "\nMake another guess!"
    end

    if message.include? "right"
      redirect to("/correct_guess")
    end
  end

  erb :play_game, :locals => {:message => message, :correct_colour => correct_colour}
end

get '/correct_guess' do
  correct_colour = "green"
  message = "You got it right! THE SECRET NUMBER IS #{SECRET_NUMBER}"
  erb :correct_guess, :locals => {:message => message, :correct_colour => correct_colour}
end

def check_guess(guess)
  print_outcomes = PlayWebGuesser.new(guess, SECRET_NUMBER)

  sn_minus = SECRET_NUMBER - 5
  sn_plus = SECRET_NUMBER + 5
  guess_as_integer = guess.to_i

  if guess.to_i >= 1
    if guess_as_integer == SECRET_NUMBER
      print_outcomes.correct
    elsif guess_as_integer.between?(sn_minus, sn_plus)
      print_outcomes.within_five_numbers
    elsif guess_as_integer > SECRET_NUMBER + 5 || guess_as_integer < SECRET_NUMBER - 5
      print_outcomes.way_too_high_or_way_too_low
    end
  end

end
