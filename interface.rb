class Interface

  TABLE_SPACE = ' ' * 20

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

  def round_end_view(main)
    puts 'Раздача закончена, победитель:'
    puts main.round_result.to_s
  end


  def start_greeting(main)
    puts 'Приветсвуем в игре BlackJack,
      пожалуйста, представьтесь'
    main.player_creation(gets.chomp!.capitalize)
  end


  def start_menu
    puts "Чтобы начать игру напишите 'Да'"
    user_answer
  end

  def round_menu(main)
    puts "Напишите 'Да' чтобы раздать карты"
    main.start_round if user_answer
    start_menu
  end


  def new_round_invite
    puts 'Сыграть еще раз?'
  end

end