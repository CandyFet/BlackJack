# frozen_string_literal: true

class Card
  NUMERIC_PATTERN = /^\d+/.freeze
  attr_accessor :rank, :suit

  def to_s
    "#{@rank} #{@suit}"
  end

  def value
    value = 0
    value += if @rank =~ NUMERIC_PATTERN
               @rank.to_i
             elsif @rank == 'A'
               11
             else
               10
             end
    value
  end
end
