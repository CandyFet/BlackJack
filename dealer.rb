class Dealer < Player

  def initialize
    @name = 'Dealer'
    @hand = Hand.new
    @bank = Bank.new
  end

  def to_s
    "#{@name} #{'*' * @hand.cards.size}"
  end

  def can_take_card?
    true if points < GameConfig::DEALER_MAX_POINTS && cards_amount < 3
  end
end