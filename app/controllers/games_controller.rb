class GamesController < ApplicationController
  def new
    @letters = ('a'..'z').to_a.sample(10)
  end

  def score
    @letters = params[:letters].split
    @word = params[:words]
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    words.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    url = "https://wagon-dictionary.herokuapp.com/#{word}"
    response = open(url)
    json = JSON.parse(response.read)
    json['found']
  end
end
