class Dealer < Player

  def initialize
    @name = 'Dealer'
    @hand = Hand.new
    @bank = Bank.new
  end

  def to_s
    "#{@name} #{'*' * @hand.cards.size}"
  end

  def mastermind(deck)
    add_card(deck.give_card) if @hand.value < GameConfig::DEALER_MAX_POINTS
  end

end