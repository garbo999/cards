class HandAnalyzer

  # Straight flush  OK
  # 4 of a kind     OK
  # Full house      OK
  # Flush           OK
  # Straight        OK
  # 3 of a kind     OK
  # 2 pair          OK
  # 1 pair          OK
  # High card

  @@hand_ranking = {high_card: 0, pair: 1, two_pair: 2, three_of_a_kind: 3, straight: 4, flush: 5, fullhouse: 6, four_of_a_kind: 7, straight_flush: 8}

  def self.show_odds(board, hand1, hand2, game='Texas Holdem')


    cd = CardDeck.new
    cd.deal_specific(hand1.cards[0], hand1.cards[1], hand2.cards[0], hand2.cards[1]) # SPLAT???
    i = 0
    cd.to_ary.combination(5).each do |comb|
      i += 1
    end
    return i

    #return 1712304
  end

  def self.evaluate(board, hand)
    cards = board.cards + hand.cards

    if HandAnalyzer.straight_flush?(board, hand)
      return :straight_flush
    elsif HandAnalyzer.is_four_of_a_kind?(board, hand)
      return :four_of_a_kind
    elsif HandAnalyzer.is_fullhouse?(board, hand)
      return :fullhouse
    elsif HandAnalyzer.is_flush?(board, hand)
      return :flush
    elsif HandAnalyzer.is_straight?(board, hand)
      return :straight
    elsif HandAnalyzer.is_three_of_a_kind?(board, hand)
      return :three_of_a_kind
    elsif HandAnalyzer.is_two_pair?(board, hand)
      return :two_pair
    elsif HandAnalyzer.is_pair?(board, hand)
      return :pair
    else
      return :high_card
    end      
  end

  def self.straight_flush?(board, hand)
    cards = board.cards + hand.cards
    if is_flush(cards) and is_straight(cards) then
      # check 21 combinations = 7 taken 5 times
      cards.combination(5).each do |comb|
        return true if is_flush(comb) and is_straight(comb)
      end
    end 
    return false
  end

  def self.is_pair?(board, hand)
    cards = board.cards + hand.cards
    h = Hash.new
    cards.each do |c| 
      h[c.rank] ? h[c.rank] += 1 : h[c.rank] = 1
    end

    h.each {|k,v| return true if v == 2}
    return false
  end

  def self.is_two_pair?(board, hand)
    cards = board.cards + hand.cards
    h = Hash.new
    cards.each do |c| 
      h[c.rank] ? h[c.rank] += 1 : h[c.rank] = 1
    end

    return h.values.count {|x| x == 2} == 2
    #return false
  end

  def self.is_three_of_a_kind?(board, hand)
    cards = board.cards + hand.cards
    h = Hash.new
    cards.each do |c| 
      h[c.rank] ? h[c.rank] += 1 : h[c.rank] = 1
    end

    h.each {|k,v| return true if v == 3}
    return false
  end

  def self.is_four_of_a_kind?(board, hand)
    cards = board.cards + hand.cards
    h = Hash.new
    cards.each do |c| 
      h[c.rank] ? h[c.rank] += 1 : h[c.rank] = 1
    end

    h.each {|k,v| return true if v == 4}
    return false
  end

  def self.is_fullhouse?(board, hand)
    cards = board.cards + hand.cards
    h = Hash.new
    cards.each do |c| 
      h[c.rank] ? h[c.rank] += 1 : h[c.rank] = 1
    end

    return (h.values.include?(3) and h.values.include?(2))
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
    card_rank = cards.map{|x| x.rank_no}.sort.uniq
    card_rank.each_cons(5) {|s| return true if s.max - s.min == 4} 
    return false
  end

end