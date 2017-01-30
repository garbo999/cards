require 'rubygems'
require 'ruby-poker'

=begin
require "./lib/card.rb"
require "./lib/carddeck.rb"
require "./lib/handanalyzer.rb"
=end

hand1 = PokerHand.new("8H 9C TC JD QH")
hand2 = PokerHand.new(["3D", "3C", "3S", "KD", "AH"])
puts hand1                
puts hand1.just_cards     
puts hand1.rank          
puts hand2                
puts hand2.rank           
puts hand1 > hand2
puts hand1.just_cards.class

# randomly generate hand2
SUITS = ['H', 'S', 'D', 'C']
RANKS = %w{ 2 3 4 5 6 7 8 9 T J Q K A}

while true do
  card = RANKS.sample + SUITS.sample
  #puts card
  hand = []
  5.times do 
    card = RANKS.sample + SUITS.sample
    hand << card
    #p hand
  end
  p hand

=begin
  cd = CardDeck.new
  hand_ours = [Card.new("9", "Spades"), Card.new("3", "Spades"), Card.new("4", "Spades"), Card.new("A", "Hearts"), Card.new("5", "Spades")]
  HandAnalyzer.evaluate([], hand_ours)
=end


end
