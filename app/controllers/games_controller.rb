require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    alphabets = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters << alphabets.sample
    end
  end

  def score
    @word = params[:attempt].upcase
    @response = 'win'
    @letters = params[:letters].split('')
    attempt = @word.split('')
    attempt.each do |letter|
      if @letters.find_index(letter)
        @letters.delete_at(@letters.find_index(letter))
      else
        @response = 'invalid'
      end
    end
    @response = 'not a word' if isnotvalid?
  end

  private

  def isnotvalid?
    url = "http://wagon-dictionary.herokuapp.com/#{@word}"
    file = open(url).read
    file_doc = JSON.parse(file)
    if file_doc['found']
      false
    else
      true
    end
  end
end
