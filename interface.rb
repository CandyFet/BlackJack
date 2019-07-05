module Interface

  TABLE_SPACE = ' ' * 20

  def user_answer
    answer = gets.chomp!.capitalize
    answer == 'Да'
  end

  def table_interface(player, dealer)
    puts dealer.center(20)
    8.times { puts TABLE_SPACE }
    puts player.center(20)
  end

  def turn_view
    puts 'Взять еще карту?'
    puts 'Напишите Да/Нет'
    user_answer
  end

  def round_end_view(winner)
    puts "Раздача закончена, победитель: #{winner}"
  end


  def start_greeting
    puts 'Приветсвуем в игре BlackJack,
      пожалуйста, представьтесь'
    gets.chomp!.capitalize
  end


  def start_menu
    puts "Чтобы начать игру напишите 'Да'"
    user_answer
  end

  def round_menu
    puts "Напишите 'Да' чтобы раздать карты"
    user_answer
  end


  def new_round_invite
    puts 'Сыграть еще раз?'
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
end