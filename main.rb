# frozen_string_literal: true
require_relative 'card'
require_relative 'player'
require_relative 'dealer'
require_relative 'hand'
require_relative 'deck'
require_relative 'bank'
require_relative 'game_bank'
require_relative 'interface'

class Main
  def init_game
    @interface = Interface.new
    if @interface.start_menu
      @interface.start_greeting(self)
      @dealer = Dealer.new
      @game_bank = GameBank.new
      @interface.round_menu(self)
    else
      abort
    end
  end

  def player_creation(name)
    @player = Player.new(name)
  end

  def start_round
    deck = Deck.new
    @player.hand.cards.clear
    @dealer.hand.cards.clear
    2.times { @player.hand.add_card(deck.give_card) }
    2.times { @dealer.hand.add_card(deck.give_card) }
    @game_bank.make_bets(@player, @dealer)
    @interface.table_interface(@player, @dealer)
    turn(deck)
    @interface.round_end_view(self)
    @interface.new_round_invite if @player.bank.amount > 10
    @interface.round_menu(self) if @interface.user_answer
    abort
  end

  def turn(deck)
    @player.hand.add_card(deck.give_card) if @interface.turn_view
    @dealer.mastermind(deck)
  end

  def round_result

    if (@player.hand.value > 21 && @dealer.hand.value > 21) || (@player.hand.value == @dealer.hand.value)
      @game_bank.refund(@player, @dealer)
      'Ничья'
    elsif @dealer.hand.value > @player.hand.value && @dealer.hand.value <= 21
      @game_bank.reward_winner(@dealer)
      @dealer.name
    else
      @game_bank.reward_winner(@player)
      @player.name
    end
  end

end

Main.new.init_game