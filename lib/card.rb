class PlayingCard
  include Comparable
  attr_reader :rank_no, :suit_no

  RANKS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
  SUITS = %w{Spades Hearts Diamonds Clubs}

  def initialize(rank, suit)
    if RANKS.include?(rank) and SUITS.include?(suit)
      @rank_no = RANKS.index(rank)
      @suit_no = SUITS.index(suit)
    else
      raise ArgumentError
    end
  end
  
  def to_ary
    [self.rank, self.suit]
  end

  def to_s
    self.rank + ' of ' + self.suit
  end

  def rank
    RANKS[@rank_no]
  end

  def suit
    SUITS[@suit_no]
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
