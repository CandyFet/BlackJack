class Dealer < Player

  def initialize
    @name = 'Dealer'
  end

  def to_s
    "#{@name} #{@hand.size*'*'}"
  end

  def mastermind(deck)
    take_cards(deck, 1) if hand_value < 17
  end

end