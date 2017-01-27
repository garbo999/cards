class HandAnalyzer

  @@hand_ranking = {high_card: 0, pair: 1, two_pair: 2, three_of_a_kind: 3, straight: 4, flush: 5, fullhouse: 6, four_of_a_kind: 7, straight_flush: 8}

  def self.show_odds(board, hand1, hand2, game='Texas Holdem')
    cd = CardDeck.new
    cd.deal_specific(hand1[0], hand1[1], hand2[0], hand2[1])
    i = 0
    n = 0
    cd.deck_of_cards.combination(5).each do |comb|
      #b = Board.new(comb)
      i += 1
      if winner(comb, hand1, hand2) 
        n += 1
      end
    end
    return n.to_f/i # = 1712304

  end

  def self.winner(board, hand1, hand2, game='Texas Holdem')
    @@hand_ranking[evaluate(board, hand1)] >= @@hand_ranking[evaluate(board, hand2)]
    #return true
  end

  def self.count_combinations(board, hand1, hand2, game='Texas Holdem')

    cd = CardDeck.new
    cd.deal_specific(hand1[0], hand1[1], hand2[0], hand2[1]) 
    i = 0
    cd.to_ary.combination(5).each do |comb|
        i += 1
    end
    return i # = 1712304
  end

  def self.evaluate(board, hand)
    cards = board + hand

    h_rank = [0,0,0,0,0,0,0,0,0,0,0,0,0]
    h_suit = [0,0,0,0]

    cards.each do |c| 
      h_rank[c.rank_no] += 1
      h_suit[c.suit_no] += 1
    end


    is_straight = is_straight?(h_rank)

    is_flush = h_suit.max >= 5

    if is_flush and is_straight and straight_flush?(cards)
      return :straight_flush
    elsif h_rank.max == 4
      return :four_of_a_kind
    elsif h_rank.include?(3) and h_rank.include?(2)
      return :fullhouse
    elsif is_flush
      return :flush
    elsif is_straight
      return :straight
    elsif h_rank.max == 3
      return :three_of_a_kind
    elsif h_rank.max == 1
      return :high_card
    elsif h_rank.count(2) == 2
      return :two_pair
    elsif h_rank.include?(2)
      return :pair
    else
      return :high_card
    end      
  end

private

  def self.straight_flush?(cards)
    # check 21 combinations = 7 taken 5 times
    h = [[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0]]
    cards.each do |c| 
      h[c.suit_no][c.rank_no]  += 1
    end
    h.each do |x|
      return true if is_straight?(x)
    end
  end

  def self.is_straight?(cards) # ACE = 1 or 14!!!
    c=0
    cards.each do |x|
      if x > 0 then
        c+=1
        if c==5 then
          return true
        end
      else
        c=0
      end
    end
    if cards[0] > 0 and cards[1] > 0 and cards[2] > 0 and cards[3] > 0 and cards[12] > 0
      return true
    else
      return false
    end
  end

end