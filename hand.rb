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
    @cards.each { |card| appearance += card.to_s + ' ' }
    appearance
  end

  def value
    value = cards.map(&:value).sum
    if ace_in_hand?
      aces_in_hand.times { value -= GameConfig::FACE_VALUE if value > GameConfig::BJ }
    end
    value
  end

  def ace_in_hand?
    cards.any?(&:ace?)
  end

  def aces_in_hand
    amount = 0
    @cards.each { |card| amount += 1 if card.ace? }
    amount
  end

  def clear
    cards.clear
  end
end
