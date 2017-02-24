class HandAnalyzer

  def self.show_odds(board, hand1, hand2, game='Texas Holdem')
    cd = CardDeck.new
    cd.deal_specific(hand1[0], hand1[1], hand2[0], hand2[1])
    i = 0
    n = 0
    ties = 0
    cd.deck_of_cards.combination(5).each do |comb|
      #b = Board.new(comb)
      i += 1
      win = winner(comb, hand1, hand2)
      if win == 1
        n += 1
      elsif win == nil
        ties += 1
      end
    end
    return [n.to_f/i, ties.to_f/i] # = 1712304

  end

  def self.winner(board, hand1, hand2, game='Texas Holdem')
    hand1_eval, hand1_high_card = evaluate(board, hand1)
    hand2_eval, hand2_high_card = evaluate(board, hand2)
    if  hand1_eval > hand2_eval
      return 1
    elsif hand1_eval < hand2_eval 
      return 2
    elsif hand1_high_card[0] > hand2_high_card[0]
      return 1
    elsif hand1_high_card[0] < hand2_high_card[0]
      return 2
    else
      (1..4).each do |x|
        if !hand1_high_card[x].nil? and !hand1_high_card[x].nil? then
          if hand1_high_card[x] > hand2_high_card[x]
            return 1
          elsif hand1_high_card[x] < hand2_high_card[x]
            return 2
          end
        else
          return 0
        end
      end
    end
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

    is_straight, s_high_card = is_straight?(h_rank)
    is_flush = h_suit.max >= 5

    if is_flush and is_straight
      straight_flush, high_card = straight_flush?(cards) 
      return :straight_flush, [high_card] if straight_flush
    end
    if h_rank.include?(4)
      return :four_of_a_kind, [h_rank.index(4), h_rank.index(1)]
    elsif h_rank.include?(3) and h_rank.include?(2)
      return :fullhouse, [h_rank.index(3), h_rank.index(2)]
    elsif is_flush
      high_card = flush_high_card(cards, h_suit.index(h_suit.max))
      return :flush, [high_card]
    elsif is_straight
      return :straight, [s_high_card]
    elsif h_rank.max == 3
      return :three_of_a_kind, [h_rank.index(3), 12-h_rank.reverse.index(1), h_rank.index(1)]
    elsif h_rank.max == 1
      return :high_card, [12-h_rank.reverse.index(1)]
    elsif h_rank.count(2) == 2
      return :two_pair, [12-h_rank.reverse.index(2), h_rank.index(2), 12-h_rank.reverse.index(1)]
    elsif h_rank.include?(2)
      return :pair, [h_rank.index(2), 12-h_rank.reverse.index(1)]
    else
      return :high_card, h_rank.sort
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
      straight, high_card = is_straight?(x)
      return straight, high_card if straight
    end
  end

  def self.flush_high_card(cards, suit_no)
    # check 21 combinations = 7 taken 5 times
    h = [[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0],[0,0,0,0,0,0,0,0,0,0,0,0,0]]
    cards.each do |c| 
      h[c.suit_no][c.rank_no]  += 1
    end
    return 12-h[suit_no].reverse.index(1)
  end

  def self.is_straight?(rank_array) # ACE = 1 or 14!!!
    # returns an array: [<true OR false>, <rank index of highest card in straight OR nil> ]
    # e.g. rank_array = [0, 2, 1, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0]
    # RANKS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
    c=0 # consecutive card counter
    rank_array_reverse = rank_array.reverse # need to reverse array to always get HIGHEST possible straight
    rank_array_reverse.each_index do |x|
      if rank_array_reverse[x] > 0 then
        c+=1
        if c==5 then
          return true, 16 - x
        end
      else
        c=0
      end
    end

    # special case of low straight = A 2 3 4 5
    if rank_array[0] > 0 and rank_array[1] > 0 and rank_array[2] > 0 and rank_array[3] > 0 and rank_array[12] > 0
      return true, 3
    else
      return false, nil # otherwise return negative result = [false, nil]
    end
  end

end