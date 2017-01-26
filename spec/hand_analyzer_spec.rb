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

    it 'knows if it has a flush' do
      board = Board.new([Card.new("2", "Spades"), Card.new("3", "Spades"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
      hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
      expect(HandAnalyzer.is_flush?(board, hand)).to eql(true)
    end

    it 'knows when it is not a flush' do
      board = Board.new([Card.new("2", "Diamonds"), Card.new("3", "Spades"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
      hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
      expect(HandAnalyzer.is_flush?(board, hand)).to eql(false)
    end

    it 'knows if it has a straight' do
      board = Board.new([Card.new("9", "Spades"), Card.new("3", "Spades"), Card.new("4", "Spades"), Card.new("A", "Hearts"), Card.new("5", "Spades")])
      hand = Hand.new( [Card.new("6", "Spades"), Card.new("2", "Hearts") ])
      expect(HandAnalyzer.is_straight?(board, hand)).to eql(true)
    end

    it 'knows when it is not a straight' do
      board = Board.new([Card.new("2", "Diamonds"), Card.new("3", "Spades"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
      hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
      expect(HandAnalyzer.is_straight?(board, hand)).to eql(false)
    end

    it 'knows when it has a straight flush' do
      board = Board.new([Card.new("2", "Diamonds"), Card.new("3", "Diamonds"), Card.new("4", "Diamonds"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
      hand = Hand.new( [Card.new("5", "Diamonds"), Card.new("6", "Diamonds") ])
      expect(HandAnalyzer.straight_flush?(board, hand)).to eql(true)
    end
  end

end