require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  context 'analysis stuff' do

    it 'responds to the class method :is_pair?' do
      expect(HandAnalyzer).to respond_to(:is_pair?)
    end

    it 'ranks an empty board and a pair as a pair' do
      expect(HandAnalyzer.is_pair?(Board.new([]), Hand.new( [Card.new("9", "Spades"), Card.new("9", "Hearts") ]) )).to eql(true)
    end

    it 'ranks a board with 5 cards and a pair as a pair' do
      board = Board.new([Card.new("2", "Spades"), Card.new("3", "Hearts"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("9", "Spades")])
      hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
      expect(HandAnalyzer.is_pair?(board, hand)).to eql(true)
    end

    it 'does not rank a board with 5 cards and no pair as a pair' do
      board = Board.new([Card.new("2", "Spades"), Card.new("3", "Hearts"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
      hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
      expect(HandAnalyzer.is_pair?(board, hand)).to eql(false)
    end

    it 'does not rank an empty board and two unpaired cards as a pair' do
      expect(HandAnalyzer.is_pair?(Board.new([]), Hand.new( [Card.new("9", "Spades"), Card.new("10", "Hearts") ]) )).to eql(false)
    end

    it 'responds to the class method :is_3_of_a_kind?' do
      expect(HandAnalyzer).to respond_to(:is_3_of_a_kind?)
    end


  end

end