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
end
