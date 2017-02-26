# 
# The 2nd stress test generates random PAIRS of hands and compares the evaluation of the WINNER (our result vs. the ruby-poker gem).
#
# 26feb17: checked 7.333 million random hands without error

require 'rubygems'
require 'ruby-poker'

require "./lib/array.rb"
require "./lib/card.rb"
require "./lib/carddeck.rb"
require "./lib/handanalyzer.rb"

PokerHand.allow_duplicates = false

def convert_result_from_ruby_poker(hand_1, hand_2)
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
RANKS_OURS = %w{2 3 4 5 6 7 8 9 10 J Q K A}
SUITS_OURS = %w{Spades Hearts Diamonds Clubs}
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
  
RANKS_ARRAY = (0..12).to_a
SUITS_ARRAY = (0..3).to_a
i = 0

while true do
  # hand_1 is the gem's hand, hand_1_ours is our hand, etc.
  # these variables have to be defined here (outside loops) due to scope issues with the loop below
  ten_card_array = []

  hand_1_ours = []
  hand_2_ours = []
  card_1 = "NONE"
  card_2 = "NONE"

  # generate 10 unique cards (2 hands)
  10.times do
    loop do # generate non-duplicate card 
      ranks_index_1 = RANKS_ARRAY.sample
      suits_index_1 = SUITS_ARRAY.sample
      card_1 = RANKS[ranks_index_1] + SUITS[suits_index_1]
      #puts card
      if !ten_card_array.include?(card_1)
        break 
      end
    end 
    ten_card_array << card_1
  end

  hand_1 = ten_card_array[0..4]
  hand_2 = ten_card_array[5..9]

=begin
  p hand_1.sort
  p hand_2.sort
=end

  # generate two hands in our format
  hand_1.each {|c| hand_1_ours << PlayingCard.new(RANKS_OURS[ RANKS.index(c[0]) ], SUITS_OURS[ SUITS.index(c[1]) ])}
  hand_2.each {|c| hand_2_ours << PlayingCard.new(RANKS_OURS[ RANKS.index(c[0]) ], SUITS_OURS[ SUITS.index(c[1]) ])}

=begin
  p hand_1_ours.show_cards
  p hand_2_ours.show_cards
  #break
=end

  #puts "evaluating hand no. #{i}"
  # build evaluate the randomly generate hands with gem vs. our HandAnalyzer and compare results
  hand_1 = PokerHand.new(hand_1)
  hand_2 = PokerHand.new(hand_2)

  if HandAnalyzer.winner([], hand_1_ours, hand_2_ours) != convert_result_from_ruby_poker(hand_1, hand_2)
    p hand_1.just_cards
    p hand_2.just_cards
    p "our result = " + HandAnalyzer.winner([], hand_1_ours, hand_2_ours).to_s
    p "their result = " + convert_result_from_ruby_poker(hand_1, hand_2).to_s
    break
  end

  # display counter every 1000 iterations
  i += 1
  if i % 1000 == 0
    puts "i=#{i}"
  end

end
