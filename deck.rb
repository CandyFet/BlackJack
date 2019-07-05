# frozen_string_literal: true

class Deck
  def initialize
    @cards = []
    Card::RANKS.each do |rank|
      Card::SUITS.each { |suit| @cards << Card.new(rank, suit) }
    end
    @cards.shuffle!
  end

  def give_card
    @cards.shift
  end
end
