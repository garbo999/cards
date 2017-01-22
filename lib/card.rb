class Card
  attr_reader :rank, :suit

  @@ranks = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
  @@suits = %w{Spades Hearts Diamonds Clubs}

  def initialize(rank, suit)
    if @@ranks.include?(rank) and @@suits.include?(suit)
      @rank = rank
      @suit = suit
    else
      raise ArgumentError
    end
  end
  
end
