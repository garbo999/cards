class NotEnoughCardsError < StandardError
end

class CardDeck
  attr_reader :deck_of_cards
   
  def initialize
    @deck_of_cards = Array.new
    PlayingCard::SUITS.each do |suit|
      PlayingCard::RANKS.each do |rank|
        @deck_of_cards << PlayingCard.new(rank, suit)
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

  def deal_specific(*card)
    card.each do |ccc|
      @deck_of_cards.delete_if{|c| c.suit == ccc.suit and c.rank == ccc.rank}
    end
  end

  def find_card(card)
    @deck_of_cards.detect{|c| c.suit == card.suit and c.rank == card.rank }
  end

end
