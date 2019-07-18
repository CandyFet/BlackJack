# frozen_string_literal: true

class Interface
  TABLE_SPACE = ' ' * 20

  def user_agreed?
    answer = gets.to_i
    answer == 1
  end

  def table_interface(player, dealer)
    puts dealer.to_s.center(20)
    8.times { puts TABLE_SPACE }
    puts player.to_s.center(20)
  end

  def round_end_view
    puts 'Раздача закончена, победитель: '
  end

  def start_greeting
    puts 'Приветсвуем в игре BlackJack,
      пожалуйста, представьтесь'
    gets.chomp!.capitalize
  end

  def start_menu
    puts "Чтобы начать игру напишите '1'"
    user_agreed?
  end

  def round_menu
    puts "Напишите '1' чтобы раздать карты"
    user_agreed?
  end

  def new_round_invite
    puts 'Чтобы сыграть еще раз напишите 1'
  end

  def show_error_message(error)
    puts "Ошибка #{error}"
  end

  def select_action
    puts '1 - пропустить ход'
    puts '2 - взять карту'
    puts '3 - открыть карты'
    gets.to_i
  end

  def show_draw
    puts 'Ничья'
  end

  def show_winner(winner)
    puts "Победил #{winner.name}"
  end

  def continue_game?
    new_round_invite
    user_agreed?
  end
end
