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

  def points
    @hand.value
  end

  def money
    bank.amount
  end

  def cards_amount
    @hand.cards.size
  end

  def can_take_card?
    true if cards_amount < 3
  end
end
