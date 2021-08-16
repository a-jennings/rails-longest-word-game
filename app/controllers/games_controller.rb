require 'json'
require 'open-uri'

class GamesController < ApplicationController

  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters.push(alphabet.sample)
    end
    @letters
  end

  def score
    word_serialized = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read
    dictionary = JSON.parse(word_serialized)
    if dictionary['found']
      word_array = params[:word].upcase.chars
      letter_array = params[:letters].delete(' ').chars
      @score_message = correct_letters?(word_array, letter_array) ? 'Success you win!' : 'Word cannot be built from those letters'
    else
      @score_message = "Sorry, but #{params[:word]} does not seem to be a valid Enlgish word..."
    end
  end

  private

  def correct_letters?(word_array, letter_array)
    number_of_letters = letter_array.length
    word_array.each do |char|
      if letter_array.include?(char)
        letter_array.delete_at(letter_array.index(char))
      end
    end
    word_array.length + letter_array.length == number_of_letters
  end
end
