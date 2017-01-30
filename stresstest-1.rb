# This stress test generates random hands and compares our evaluation (HandAnalyzer.evaluate([], hand_ours)) 
# with the ruby-poker gem's evaluation (hand.rank).
#
# Here are the only 'errors' I found by running this test (since we don't return a different result for a Royal Flush):
#   "Th Jh Qh Kh Ah"
#   "Royal Flush"
#   [:straight_flush, [12]]
#
#   "Qc Ac Jc Tc Kc"
#   "Royal Flush"
#   [:straight_flush, [12]]

require 'rubygems'
require 'ruby-poker'

require "./lib/card.rb"
require "./lib/carddeck.rb"
require "./lib/handanalyzer.rb"

PokerHand.allow_duplicates = false

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
  hand = [] # these variables have to be defined here due to scope issues with the loop below
  hand_ours = []
  card = "NONE"
  ranks_index = "NONE"
  suits_index = "NONE"

  5.times do 
    loop do 
      ranks_index = (0..12).to_a.sample
      suits_index = (0..3).to_a.sample
      card = RANKS[ranks_index] + SUITS[suits_index]
      #puts card
      break if !hand.include?(card)
    end 
    hand << card
    card_ours = PlayingCard.new(ranks_ours[ranks_index], suits_ours[suits_index])
    hand_ours << card_ours
    #p hand
  end

  # build evaluate the randomly generate hands with gem vs. our HandAnalyzer and compare results
  hand = PokerHand.new(hand)
  our_ranking = HandAnalyzer.evaluate([], hand_ours)
  test_comparison = RANKING_CONVERSION[hand.rank] == our_ranking[0].to_s

  if ! test_comparison
    p hand.just_cards
    p hand.rank
    p HandAnalyzer.evaluate([], hand_ours)
    p test_comparison
    break
  end

  # display counter every 1000 iterations
  i += 1
  if i % 1000 == 0
    puts "i=#{i}"
  end

end
