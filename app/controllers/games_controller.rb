require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @random_array = []
    alph_array = Array('A'..'Z')
    @random_array << alph_array.sample while @random_array.length < 9
  end

  def score
    @random_array = params[:grid]
    @guess = params[:guess].upcase
    chars = @guess.split('')

    if chars.all? { |letter| @guess.count(letter) <= @random_array.count(letter) } == true
      if english_word?(@guess)
        score = @guess.length
        @score = [score, "Well Done!"]
      else
      @score = [0, "Sorry but #{@guess} not an english word"]
      end
    else
      @score = [0, "not in the grid"]
    end
  end

  def english_word?(guess)
    response = open("https://wagon-dictionary.herokuapp.com/#{guess}")
    json = JSON.parse(response.read)
  return json['found']
  end
end
