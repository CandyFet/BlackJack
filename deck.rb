# frozen_string_literal: true

class Deck
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %W[\u2660 \u2663 \u2665 \u2666].freeze
  def initialize
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        card = Card.new
        card.rank = rank
        card.suit = suit
        @cards << card
      end
    end
    @cards.shuffle!
  end

  def give_card
    @cards.shift
  end
end
