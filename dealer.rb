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
    @hand.add_card(deck.give_card)
  end

end