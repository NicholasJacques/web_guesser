require 'sinatra'
require 'sinatra/reloader'

class WebGuesser

  attr_reader :secret_number

  def initialize
    @secret_number = rand(100)
  end

  def check_guess(guess = nil)
    if guess.nil?
      "Make a guess"
    elsif guess > secret_number + 10
      "Way too high!"
    elsif guess > secret_number
      "Too High!"
    elsif guess < secret_number - 10
      "Way too low!"
    elsif guess < secret_number
      "Too low!"
    else
      "Correct! The SECRET NUMBER is #{secret_number}"
    end
  end

end

web_guesser = WebGuesser.new
get '/' do
  guess = params["guess"].to_i
  erb :index, :locals => {:message => web_guesser.check_guess(guess)}
end



