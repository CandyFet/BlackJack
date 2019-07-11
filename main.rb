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
  def initialize
    @interface = Interface.new
    @player = create_player
    @dealer = Dealer.new
    @game_bank = GameBank.new(0)
    play_game
  end

  def init_game
    @interface = Interface.new
    if @interface.start_menu
      @player = create_player
      @dealer = Dealer.new
      @game_bank = GameBank.new(0)
      play_game if @interface.round_menu
    else
      abort
    end
  end

  def create_player
    name = @interface.start_greeting
    Player.new(name)
  rescue ArgumentError => e
    @interface.show_error_message(e)
  end

  def player_turn(action)
    case action
    when 1 then @dealer.add_card(@deck.give_card) if @dealer.can_take_card?
    when 2 then @player.add_card(@deck.give_card) if @player.can_take_card?
    when 3 then @dealer.add_card(@deck.give_card) if @dealer.can_take_card?
    end
  end

  def round_result
    winner = determine_winner
    if winner.nil?
      @game_bank.refund(@player, @dealer)
      @interface.show_draw
    else
      @game_bank.reward_winner(winner)
      @interface.show_winner(winner)
    end
  end

  def reset_state
    @deck = Deck.new
    @player.hand.clear
    @dealer.hand.clear
  end

  def deal_cards
    2.times { @player.add_card(@deck.give_card) }
    2.times { @dealer.add_card(@deck.give_card) }
  end

  def determine_winner
    if (@player.points > GameConfig::BJ) && (@dealer.points > GameConfig::BJ)
      nil
    elsif @player.points == @dealer.points
      nil
    elsif @player.points > GameConfig::BJ
      @dealer
    elsif @dealer.points > GameConfig::BJ
      @player
    else
      @dealer.points > @player.points ? @dealer : @player
    end
  end

  def play_game
    loop do
      break unless players_can_make_bets?

      reset_state
      deal_cards
      play_round
      round_result
      break unless @interface.continue_game?
    end
  end

  def play_round
    loop do
      action = @interface.select_action
      player_turn(action)
      dealer_turn
      break if !@player.can_take_card? && !@dealer.can_take_card?
    end
  end

  def players_can_make_bets?
    true if @player.money > 10 && @dealer.money > 10
  end
end

Main.new.init_game
