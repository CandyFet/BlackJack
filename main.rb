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
    table_interface(@player, @dealer)
  end

  def user_answer
    answer = gets.chomp!.capitalize
    answer == 'Да'
  end

  def table_interface(player, dealer)
    puts dealer.to_s.center(TABLE_SPACE)
    8.times(puts(TABLE_SPACE))
    puts player.to_s.center(TABLE_SPACE)
  end
end
