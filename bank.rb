# frozen_string_literal: true

class Bank

  attr_reader :amount

  def initialize
    @amount = 100
  end

  def debit(value)
    @amount += value
    value
  end

  def withdraw(value)
    @amount -= value
    value
  end

end
