require 'open-uri'
require 'json'
# Games Controller
class GamesController < ApplicationController
  def new
    @letters = (0...10).map { |_char| ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word]
    letters = params[:letters]
    if valid_word?(@word, letters) && correct_word?(@word)
      @response = "Congratulations! #{@word.upcase} is a valid Enlish word"
    elsif !valid_word?(@word, letters)
      @response = "Sorry but #{@word} can't be build out of #{letters}"
    elsif !correct_word?(@word)
      @response = "Sorry but #{@word} does not seem to be a valid English word"
    end
  end

  def correct_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    JSON.parse(open(url).read)['found']
  end

  def valid_word?(word, letters)
    word_split = word.upcase.chars
    word_split.all? do |letter|
      word_split.count(letter) <= letters.count(letter)
    end
  end
end
