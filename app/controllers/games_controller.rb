class GamesController < ApplicationController

  def new
    alphabet = ('A'..'Z').to_a
    @letters = []
    10.times do
      @letters.push(alphabet.sample)
    end
    p @letters


  end

  def score
  end


end
