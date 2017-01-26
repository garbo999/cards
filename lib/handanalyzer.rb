class HandAnalyzer

  # Straight flush
  def self.straight_flush?(board, hand)
    is_flush(board.cards + hand.cards) and is_straight(board.cards + hand.cards)
  end

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

  def self.is_flush?(board, hand)
    is_flush(board.cards + hand.cards)
  end

  def self.is_straight?(board, hand)
    is_straight(board.cards + hand.cards)
  end

  private

  def self.is_flush(cards)
    h = Hash.new
    cards.each do |c| 
      h[c.suit] ? h[c.suit] += 1 : h[c.suit] = 1
    end

    h.each {|k,v| return true if v >= 5}
    return false
  end

  def self.is_straight(cards)
    card_rank = cards.map{|x| x.rank_no}.sort.uniq!

    return false
  end

end