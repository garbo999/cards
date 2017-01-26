class Card
  include Comparable
  attr_reader :rank, :suit

  @@ranks = %w{2 3 4 5 6 7 8 9 10 J Q K A}
  @@suits = %w{Spades Hearts Diamonds Clubs}

  def initialize(rank, suit)
    if @@ranks.include?(rank) and @@suits.include?(suit)
      @rank = rank
      @suit = suit
    else
      raise ArgumentError
    end
  end
  
  def to_ary
    [@rank, @suit]
  end

  def rank_no
    @@ranks.index(@rank)
  end

  def suit_no
    @@suits.index(@suit)
  end

  def <=>(other_card) # do we need this???
    if self.rank_no < other_card.rank_no
      -1
    elsif self.rank_no > other_card.rank_no
      1
    else
      if self.suit_no < other_card.suit_no
        -1
      elsif self.suit_no > other_card.suit_no
        1
      else
        0 # could this occur???
      end
    end
  end


end
