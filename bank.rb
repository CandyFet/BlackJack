# frozen_string_literal: true

class Bank
  attr_reader :amount

  def initialize(amount = 100)
    @amount = amount
  end

  def debit(value)
    @amount += value
  end

  def withdraw(value)
    @amount -= value if @amount > value
  end
end
