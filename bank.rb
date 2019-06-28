# frozen_string_literal: true

class Bank
  attr_reader :amount

  def initialize(user)
    @amount = { user.to_sym => 100 } || {}
  end

  def make_bet(user)
    @amount[user.to_sym] -= 10 if @amount[user.to_sym] >= 10
  end

end
