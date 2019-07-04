class GameBank < Bank

  attr_reader :amount

  def initialize
    @amount = 0
  end

  def make_bets(*players)
    players.each { |player| @amount += player.bank.withdraw(10) }
  end

  def reward_winner(winner)
    winner.bank.debit(20)
  end

  def refund(*players)
    players.each { |player| player.bank.debit(10) }
  end
end