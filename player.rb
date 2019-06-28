class Player

  attr_reader :name

  def initialize(name)
    @name = name
  end

  def starting_bank
    Bank.new(@name)
  end

end