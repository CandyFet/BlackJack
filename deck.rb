class Deck

  def initialize
    ranks = %w[2 3 4 5 6 7 8 9 10 J Q K A]
    suits = %w[<> + <3 ^]
    cards = []
    ranks.each do |rank|
      suits.each {|suit| cards << "#{rank} #{suit}" }
    end
    cards.shuffle!
  end
end