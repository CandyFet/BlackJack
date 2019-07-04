# frozen_string_literal: true

class Hand
  attr_reader :cards
  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def to_s
    appearance = ''
    @cards.each { |card| appearance += card.to_s + " " }
    appearance
  end

  def value
    value = 0
    @cards.each do |card|
      value += if card.rank == 'A' && value > 10
                 1
               else
                 card.value
               end
    end
    value
  end
end
