require 'open-URI'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score

    @word = params[:game]
    @letters_array = params[:letters_array].split(" ")
    if included?(@word, @letters_array) == true
      @result = "Sorry but #{@word} can´t be built ouf of #{@letters_array}"
    elsif  english_word?(@word) == false
      @result = "Sorry but #{@word} doesn´t seem to be a valide English word"
    else
      @result = "Congratulations #{@word} is a valid word"
    end
  end


  def english_word?(word)
    response = open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    return json['found']
  end


  def included?(word, array)
    array_of_letters = word.upcase.split("")

    counter = 0
    array_of_letters.each do |letter|
      counter += 1 unless array.include?(letter) == true
    end
    if counter > 0
      return true
    else
      return false
    end
  end

end
