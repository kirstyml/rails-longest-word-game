require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
  grid = []
  (1..9).each { grid << ("A".."Z").to_a.sample }
  @letters = grid
  end

  def score
    @attempt = params['longest-word']
    attempt_chars = params['longest-word'].upcase.chars
    @valid = attempt_chars.all? { |letter| attempt_chars.count(letter) <= params[:letters_board].count(letter) }
    url_base = 'https://wagon-dictionary.herokuapp.com/'
    url = "#{url_base}#{params['longest-word']}"
    url_serialized = open(url).read
    word_details = JSON.parse(url_serialized)
    @english = word_details["found"]
    @score = word_details["length"] if @english == true;
  end
end
