class Deck
  def initialize
    ranks = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    suits = %W[\u2660 \u2663 \u2665 \u2666]
    @cards = []
    ranks.each do |rank|
      suits.each { |suit| @cards << "#{rank} #{suit}" }
    end
    @cards.shuffle!
  end

  def give_card
    @cards.shift
  end
end
