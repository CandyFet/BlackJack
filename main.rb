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

  PLAYER_ACTIONS = {
    skip: 1,
    take_card: 2,
    open_cards: 3
  }.freeze

  def initialize
    @interface = Interface.new
    @player = create_player
    @dealer = Dealer.new
    @game_bank = GameBank.new(0)
    play_game
  end

  def create_player
    name = @interface.start_greeting
    Player.new(name)
  rescue ArgumentError => e
    @interface.show_error_message(e)
  end

  def deal_cards
    GameConfig::START_CARDS.times { @player.add_card(@deck.give_card) }
    GameConfig::START_CARDS.times { @dealer.add_card(@deck.give_card) }
  end

  def player_turn(action)
    if action == PLAYER_ACTIONS[:take_card]
      return unless @player.can_take_card?

      @player.add_card(@deck.give_card)
    end
  end

  def dealer_turn
    @dealer.add_card(@deck.give_card) if @dealer.can_take_card?
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

  def play_game
    loop do
      break unless players_can_make_bets?

      reset_state
      deal_cards
      @game_bank.make_bets(@player, @dealer)
      @interface.table_interface(@player, @dealer)
      play_round
      round_result
      break unless @interface.continue_game?
    end
  end

  def play_round
    loop do
      action = @interface.select_action
      player_turn(action)
      break if action == PLAYER_ACTIONS[:open_cards]

      dealer_turn
      break if !@player.can_take_card? && !@dealer.can_take_card?
    end
  end

  private

  def players_can_make_bets?
    @player.money >= GameConfig::BET_SIZE && @dealer.money >= GameConfig::BET_SIZE
  end

  def determine_winner
    return if (@player.points > GameConfig::BJ) && (@dealer.points > GameConfig::BJ)
    return if @player.points == @dealer.points
    return @dealer if @player.points > GameConfig::BJ
    return @player if @dealer.points > GameConfig::BJ

    [@dealer, @player].max_by(&:points)
  end

  def reset_state
    @deck = Deck.new
    @player.hand.clear
    @dealer.hand.clear
  end
end

Main.new
