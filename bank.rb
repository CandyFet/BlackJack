# frozen_string_literal: true

class Bank
  attr_reader :amount

  def initialize()
    @amount = 100
  end

  def make_bet
    @amount -= 10 if @amount >= 10
  end

  def win_bet(value)
    @amount += value
  end

end
