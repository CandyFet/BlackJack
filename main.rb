# frozen_string_literal: true

require_relative 'game_config'
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
    if Interface.start_menu
      @player = player_creation
      @dealer = Dealer.new
      @game_bank = GameBank.new
      start_round if Interface.round_menu
    else
      abort
    end
  end

  def player_creation
    name = Interface.start_greeting
    Player.new(name)
  rescue ArgumentError => e
    Interface.show_error_message(e)
  end

  def start_round
    deck = Deck.new
    @player.hand.clear
    @dealer.hand.clear
    2.times { @player.add_card(deck.give_card) }
    2.times { @dealer.add_card(deck.give_card) }
    @game_bank.make_bets(@player, @dealer)
    Interface.table_interface(@player.to_s, @dealer.to_s)
    case Interface.select_action
    when 1 then @dealer.mastermind(deck)
    when 2 then @player.add_card(deck.give_card)
    when 3 then
      @dealer.mastermind(deck)
    end
    turn(deck)
    Interface.round_end_view(round_result)
    Interface.new_round_invite if @player.bank.amount > 10
    Interface.round_menu if Interface.user_answer
    abort
  end

  def turn(deck)
    @player.hand.add_card(deck.give_card) if Interface.turn_view
    @dealer.mastermind(deck)
  end

  def round_result
    if (win_condition(@player) && win_condition(@dealer)) || (@player.hand.value == @dealer.hand.value)
      @game_bank.refund(@player, @dealer)
      'Ничья'
    elsif (@dealer.hand.value > @player.hand.value) && (@dealer.hand.value <= GameConfig::BJ)
      @game_bank.reward_winner(@dealer)
      @dealer.name
    else
      @game_bank.reward_winner(@player)
      @player.name
    end
  end

  def win_condition(player)
    true if player.hand.value <= GameConfig::BJ
    false
  end
end

Main.new.init_game
