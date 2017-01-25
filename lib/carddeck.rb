class NotEnoughCardsError < StandardError
end

class CardDeck
  @@ranks = %w{A 2 3 4 5 6 7 8 9 10 J Q K}
  @@suits = %w{Spades Hearts Diamonds Clubs}

  def initialize
    #puts "@@ranks=#{@@ranks}"
    #puts "@@suits=#{@@suits}"
    @deck_of_cards = Array.new
    @@suits.each do |suit|
      #puts suit
      @@ranks.each do |rank|
        #puts rank
        @deck_of_cards << Card.new(rank, suit)
      end
    end
  end

  def count_cards
    @deck_of_cards.count
  end

  def print_whole_deck
    @deck_of_cards.each_slice(13) do |thirteen_cards|
      thirteen_cards.each do |card|
        print card.rank + "," + card.suit + " "
      end
      print "\n"
    end
  end

  def shuffle!
    @deck_of_cards.shuffle!
  end

  def to_ary
    @a = []
    @deck_of_cards.each.each do |card|
        @a << [card.rank, card.suit]
    end
    return @a
  end

  def deal(number_of_cards=1)
    if number_of_cards > count_cards # count_cards is an instance method!
      raise NotEnoughCardsError
    else
      @deck_of_cards.pop(number_of_cards)
    end
  end

  def deal_specific(*cards)
  end

end
