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
    value -= GameConfig::BET_SIZE if ace_in_hand? && value > GameConfig::BJ
    value
  end

  def ace_in_hand?
    cards.any?(&:ace?)
  end

  def clear
    cards.clear
  end
end
