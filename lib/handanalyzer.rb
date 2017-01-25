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
    cards = board.cards + hand.cards
    h = Hash.new
    cards.each do |c| 
      h[c.rank] ? h[c.rank] += 1 : h[c.rank] = 1
    end

    h.each {|k,v| return true if v == 2}
    return false
  end

end