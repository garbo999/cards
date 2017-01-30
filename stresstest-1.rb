require 'rubygems'
require 'ruby-poker'


require "./lib/card.rb"
require "./lib/carddeck.rb"
require "./lib/handanalyzer.rb"


hand1 = PokerHand.new("8H 9C TC JD QH")
hand2 = PokerHand.new(["3D", "3C", "3S", "KD", "AH"])
=begin
puts hand1                
puts hand1.just_cards     
puts hand1.rank          
puts hand2                
puts hand2.rank           
puts hand1 > hand2
puts hand1.just_cards.class
=end

# randomly generate hand2
SUITS = ['S', 'H', 'D', 'C']
RANKS = %w{ 2 3 4 5 6 7 8 9 T J Q K A}
ranks_ours = %w{2 3 4 5 6 7 8 9 10 J Q K A}
suits_ours = %w{Spades Hearts Diamonds Clubs}

#while true do
  #puts card
  hand = []
  hand_ours = []
  5.times do 
    ranks_index = (0..12).to_a.sample
    suits_index = (0..3).to_a.sample
    card = RANKS[ranks_index] + SUITS[suits_index]
    hand << card
    card_ours = PlayingCard.new(ranks_ours[ranks_index], suits_ours[suits_index])
    hand_ours << card_ours
    #p hand
  end
  p hand
  p hand_ours



  #cd = CardDeck.new
  #hand_ours = [PlayingCard.new(hand[0][0], ranks_ours[hand[0][1]]), PlayingCard.new(hand[1][0], SUITS_CONVERSION[hand[1][1]]), PlayingCard.new(hand[2][0], SUITS_CONVERSION[hand[2][1]]), PlayingCard.new(hand[3][0], SUITS_CONVERSION[hand[3][1]]), PlayingCard.new(hand[4][0], SUITS_CONVERSION[hand[4][1]])]
  #hand_ours_eval = HandAnalyzer.evaluate([], hand_ours)
  #p 'XXXX: ' + hand_ours_eval.to_s


#end
