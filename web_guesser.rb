require 'sinatra'
require 'sinatra/reloader'

class WebGuesser

  attr_reader :number,
              :guess_count

  def initialize
    @number = rand(1..100)
    @guess_count = 5
  end

  def count_guess
    @guess_count -=1
  end

  def reset
    @guess_count = 5
    @number = rand(1..100)
  end

  def check_count
    if guess_count == 0
      reset
      " You Lose! New Number!"
    else
      ""
    end
  end

  def check_guess(guess)
    count_guess unless guess == 0
    if guess > (number + 10)
      message = "Way too high!"
    elsif guess > number
      message = "Too high!"
    elsif guess < (number - 10)
      message = "Way too low!"
    elsif guess < number
      message = "Too low!"
    else
      message = "Correct! The secret number was #{number}!"
      reset
    end
    message + check_count
  end
end

web_guesser = WebGuesser.new

get '/' do
  guess = params["guess"].to_i
  message = web_guesser.check_guess(guess)
  erb :index, :locals => { :number => web_guesser.number, :message => message, :guess_count => web_guesser.guess_count }
end