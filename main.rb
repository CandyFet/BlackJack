# frozen_string_literal: true

require_relative 'player'
require_relative 'dealer'
require_relative 'deck'
require_relative 'bank'

class Main
  TABLE_SPACE = ' ' * 20

  def init_game
    if start_menu
      start_greeting
      @dealer = Dealer.new
      @dealer.starting_bank
      @player.starting_bank
      round_menu
    else
      abort
    end
  end

  def start_greeting
    puts 'Приветсвуем в игре BlackJack,
      пожалуйста, представьтесь'
    player_creation(gets.chomp!.capitalize)
  end

  def player_creation(name)
    @player = Player.new(name)
  end

  def start_menu
    puts "Чтобы начать игру напишите 'Да'"
    user_answer
  end

  def round_menu
    puts "Напишите 'Да' чтобы раздать карты"
    start_round if user_answer
    start_menu
  end

  def start_round
    deck = Deck.new
    @player.take_cards(deck, 2)
    @dealer.take_cards(deck, 2)
    @player.player_bank.make_bet
    @player.player_bank.make_bet
    table_interface(@player, @dealer)
    turn(deck)
    round_end_view
    new_round_invite if @player.player_bank > 10
    round_menu if user_answer
    abort
  end

  def user_answer
    answer = gets.chomp!.capitalize
    answer == 'Да'
  end

  def table_interface(player, dealer)
    puts dealer.to_s.center(20)
    8.times { puts TABLE_SPACE }
    puts player.to_s.center(20)
  end

  def turn_view
    puts 'Взять еще карту?'
    puts 'Напишите Да/Нет'
    user_answer
  end

  def turn(deck)
    @player.take_cards(deck, 1) if turn_view
    @dealer.mastermind(deck)
  end

  def round_end_view
    puts 'Раздача закончена, победитель:'
    puts round_result.to_s
  end

  def round_result
    if (@player.hand_value > 21 && @dealer.hand_value > 21) || (@player.hand_value == @dealer.hand_value)
      'Ничья'
      @dealer.player_bank.win_bet(10)
      @player.player_bank.win_bet(10)
    elsif @dealer.hand_value > @player.hand_value && @dealer.hand_value <= 21
      @dealer.name
      @dealer.player_bank.win_bet(20)
    else
      @player.name
      @player.player_bank.win_bet(20)
    end
  end

  def new_round_invite
    puts 'Сыграть еще раз?'
  end
end

Main.new.init_game