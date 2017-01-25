class HandAnalyzer

  # Straight flush
  # 4 of a kind
  # Full house
  # Flush
  # Straight
  # 3 of a kind
  # 2 pair
  # 1 pair
  # High card
  
  def self.is_pair?(board, hand)
    #cards = board.cards + hand.cards
    cards = hand.cards
    #cards.sort
    #cards_with_rank_only = cards.map {|c| c.rank}
    h = Hash.new
    cards.each do |c| 
      if h[c.rank]
        h[c.rank] += 1
      else
        h[c.rank] = 1
      end
    end

    h.each {|k,v| if v == 2 ; return true ; end}
    return false
  end

end