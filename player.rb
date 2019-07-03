class Player
  VALUE_PATTERN = /^\S+/.freeze
  NUMERIC_PATTERN = /^\d+/.freeze

  attr_reader :name, :bank

  def initialize(name)
    @name = name
    @hand = []
  end

  def starting_bank
    @bank = Bank.new
  end

  def take_cards(deck, value)
    value.times { @hand << deck.give_card } if value.class == Integer
  end

  def to_s
    "#{@name} #{@hand}"
  end

  def hand_value
    ranks = []
    @hand.each { |card| ranks << card[VALUE_PATTERN] }
    values_sum(ranks)
  end

  private

  def values_sum(ranks)
    sum = 0
    ranks.each do |rank|
      sum += if rank =~ NUMERIC_PATTERN
               rank.to_i
             elsif rank == 'A'
               if sum <= 10
                 11
               else
                 1
               end
             else
               10
             end
    end
    sum
  end
end
