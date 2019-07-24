# frozen_string_literal: true

class Card
  RANKS = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  SUITS = %w[♦ ♥ ♠ ♣].freeze

  attr_reader :rank, :suit, :value

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = determine_value
  end

  def to_s
    "#{rank} #{suit}"
  end

  def ace?
    rank == 'A'
  end

  private

  def determine_value
    if %w[J Q K].include?(rank)
      GameConfig::FACE_VALUE
    elsif ace?
      GameConfig::ACE_VALUE
    else
      rank.to_i
    end
  end

end
