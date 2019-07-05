# frozen_string_literal: true

class Player
  attr_reader :name, :bank, :hand

  def initialize(name)
    @name = name
    @hand = Hand.new
    @bank = Bank.new
  end

  def to_s
    "#{@name} #{@hand}"
  end

  def add_card(card)
    @hand.add_card(card)
  end

  def debit(amount)
    @bank.debit(amount)
  end

  def withdraw(amount)
    @bank.withdraw(amount)
  end
end
