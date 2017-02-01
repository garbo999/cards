# This 2nd stress test generates random PAIRS of hands and compares the evaluation of the WINNER (our result vs. the ruby-poker gem).
#

require 'rubygems'
require 'ruby-poker'

require "./lib/card.rb"
require "./lib/carddeck.rb"
require "./lib/handanalyzer.rb"

PokerHand.allow_duplicates = false

def result_convert(hand_1, hand_2)
  if hand_1 > hand_2
    return 1
  elsif hand_1 < hand_2
    return 2
  else
    return 0
  end
end

# some conversion stuff
SUITS = ['S', 'H', 'D', 'C']
RANKS = %w{ 2 3 4 5 6 7 8 9 T J Q K A}
ranks_ours = %w{2 3 4 5 6 7 8 9 10 J Q K A}
suits_ours = %w{Spades Hearts Diamonds Clubs}
RANKING_CONVERSION = { 'Straight Flush' => 'straight_flush',
  'Four of a kind' => 'four_of_a_kind',
  'Full house' => 'fullhouse',
  'Flush' => 'flush',
  'Straight' => 'straight',
  'Three of a kind' => 'three_of_a_kind',
  'Two pair' => 'two_pair',
  'Pair' => 'pair',
  'Highest Card' => 'high_card'
}
  
i = 0
while true do
  # hand_1 is the gem's hand, hand_1_ours is our hand, etc.
  # these variables have to be defined here (outside loops) due to scope issues with the loop below
  hand_1 = [] 
  hand_2 = [] 
  hand_1_ours = []
  hand_2_ours = []
  card_1 = "NONE"
  card_2 = "NONE"
  ranks_index_1 = "NONE"
  ranks_index_2 = "NONE"
  suits_index_1 = "NONE"
  suits_index_2 = "NONE"

  5.times do 
    loop do # generate non-duplicate card for hand_1
      ranks_index_1 = (0..12).to_a.sample
      suits_index_1 = (0..3).to_a.sample
      card_1 = RANKS[ranks_index_1] + SUITS[suits_index_1]
      #puts card
      break if !hand_1.include?(card_1)
    end 
    loop do # generate non-duplicate card for hand_2
      ranks_index_2 = (0..12).to_a.sample
      suits_index_2 = (0..3).to_a.sample
      card_2 = RANKS[ranks_index_2] + SUITS[suits_index_2]
      #puts card
      break if !hand_2.include?(card_2) and !hand_1.include?(card_2) # don't allow duplicate cards between hands
    end 
    hand_1 << card_1
    hand_2 << card_2
    card_ours_1 = PlayingCard.new(ranks_ours[ranks_index_1], suits_ours[suits_index_1])
    card_ours_2 = PlayingCard.new(ranks_ours[ranks_index_2], suits_ours[suits_index_2])
    hand_1_ours << card_ours_1
    hand_2_ours << card_ours_2
    #p hand_1
  end

  # build evaluate the randomly generate hands with gem vs. our HandAnalyzer and compare results
  hand_1 = PokerHand.new(hand_1)
  hand_2 = PokerHand.new(hand_2)
  #our_ranking = HandAnalyzer.evaluate([], hand_1_ours)
  #test_comparison = RANKING_CONVERSION[hand_1.rank] == our_ranking[0].to_s


  if HandAnalyzer.winner([], hand_1_ours, hand_2_ours) != result_convert(hand_1, hand_2)
    p hand_1.just_cards
    p hand_2.just_cards
    p "our result = " + HandAnalyzer.winner([], hand_1_ours, hand_2_ours).to_s
    p "their result = " + result_convert(hand_1, hand_2).to_s
    break
  end
=begin
  if ! test_comparison
    p hand_1.just_cards
    p hand_1.rank
    p HandAnalyzer.evaluate([], hand_1_ours)
    p test_comparison
    break
  end
=end

  # display counter every 1000 iterations
  i += 1
  if i % 1000 == 0
    puts "i=#{i}"
  end

end
