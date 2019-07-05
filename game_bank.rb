# frozen_string_literal: true

class GameBank < Bank
  attr_reader :amount

  def make_bets(*players)
    players.each do |player|
      player.withdraw(GameConfig::BET_SIZE)
      debit(GameConfig::BET_SIZE)
    end
  end

  def reward_winner(winner)
    winner.debit(amount)
    reset_bank
  end

  def refund(*players)
    players.each { |player| player.debit(GameConfig::BET_SIZE) }
    reset_bank
  end

  private

  def reset_bank
    @amount = 0
  end
end
