# frozen_string_literal: true

class Bank
  attr_reader :amount

  def initialize(user)
    @amount = 100
  end

  def make_bet(user)
    @amount -= 10 if @amount >= 10
  end

end
