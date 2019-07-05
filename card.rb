# frozen_string_literal: true

class Card
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[♦ ♥ ♠ ♣].freeze
  ACE_VALUE = 11
  FACE_VALUE = 10

  attr_reader :rank, :suit, :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = determine_value
  end

  def to_s
    "#{rank} #{suit}"
  end

  private

  def determine_value
    if %w[J Q K].include?(rank)
      FACE_VALUE
    elsif ace?
      ACE_VALUE
    else
      rank.to_i
    end
  end

  def ace?
    rank == 'A'
  end
end
