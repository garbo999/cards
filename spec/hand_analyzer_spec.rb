require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  before :each do
    board = Board.new([Card.new("2", "Spades"), Card.new("3", "Hearts"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("9", "Spades")])
    hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
    @one_pair = board, hand

    board = Board.new([Card.new("2", "Spades"), Card.new("3", "Hearts"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
    @high_card = board, hand

    board = Board.new([])
    hand = Hand.new( [Card.new("9", "Spades"), Card.new("10", "Hearts") ])
    @empty_board_with_no_pair = board, hand

    board = Board.new([Card.new("2", "Spades"), Card.new("3", "Spades"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
    @flush = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("3", "Spades"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
    @not_a_flush = board, hand

    board = Board.new([Card.new("9", "Spades"), Card.new("3", "Spades"), Card.new("4", "Spades"), Card.new("A", "Hearts"), Card.new("5", "Spades")])
    hand = Hand.new( [Card.new("6", "Spades"), Card.new("2", "Hearts") ])
    @straight = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("3", "Spades"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("10", "Spades"), Card.new("9", "Hearts") ])
    @not_a_straight = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("3", "Diamonds"), Card.new("4", "Diamonds"), Card.new("A", "Hearts"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("5", "Diamonds"), Card.new("6", "Diamonds") ])
    @straight_flush = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("3", "Diamonds"), Card.new("4", "Diamonds"), Card.new("A", "Diamonds"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("5", "Diamonds"), Card.new("6", "Hearts") ])
    @not_a_straight_flush = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("2", "Clubs"), Card.new("4", "Diamonds"), Card.new("A", "Diamonds"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("2", "Hearts"), Card.new("6", "Hearts") ])
    @three_of_a_kind = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("2", "Clubs"), Card.new("4", "Diamonds"), Card.new("2", "Spades"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("2", "Hearts"), Card.new("6", "Hearts") ])
    @four_of_a_kind = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("10", "Clubs"), Card.new("4", "Diamonds"), Card.new("A", "Diamonds"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("2", "Hearts"), Card.new("4", "Clubs") ])
    @two_pair = board, hand

    board = Board.new([Card.new("2", "Diamonds"), Card.new("2", "Clubs"), Card.new("4", "Diamonds"), Card.new("6", "Clubs"), Card.new("K", "Spades")])
    hand = Hand.new( [Card.new("2", "Hearts"), Card.new("6", "Hearts") ])
    @full_house = board, hand

  end

  context 'evaluator' do
    it 'responds to the class method :evaluate' do
      expect(HandAnalyzer).to respond_to(:evaluate)
    end
  end

  context 'basic analysis methods' do

    it 'responds to the class method :is_pair?' do
      expect(HandAnalyzer).to respond_to(:is_pair?)
    end

    it 'ranks an empty board and a pair as a pair' do
      expect(HandAnalyzer.is_pair?(Board.new([]), Hand.new( [Card.new("9", "Spades"), Card.new("9", "Hearts") ]) )).to eql(true)
    end

    it 'ranks a board with 5 cards and a pair as a pair' do
      expect(HandAnalyzer.is_pair?(*@one_pair)).to eql(true)
    end

    it 'does not rank a board with 5 cards and no pair as a pair' do
      expect(HandAnalyzer.is_pair?(*@high_card)).to eql(false)
    end

    it 'does not rank an empty board and two unpaired cards as a pair' do
      expect(HandAnalyzer.is_pair?(*@empty_board_with_no_pair)).to eql(false)
    end

    it 'knows if it has a flush' do
      expect(HandAnalyzer.is_flush?(*@flush)).to eql(true)
    end

    it 'knows when it is not a flush' do
      expect(HandAnalyzer.is_flush?(*@not_a_flush)).to eql(false)
    end

    it 'knows if it has a straight' do
      expect(HandAnalyzer.is_straight?(*@straight)).to eql(true)
    end

    it 'knows when it is not a straight' do
      expect(HandAnalyzer.is_straight?(*@not_a_straight)).to eql(false)
    end

    it 'knows when it has a straight flush' do
      expect(HandAnalyzer.straight_flush?(*@straight_flush)).to eql(true)
    end

    it 'knows when it is not a straight flush' do # write some more gnarly edge case examples !?
      expect(HandAnalyzer.straight_flush?(*@not_a_straight_flush)).to eql(false)
    end

    it 'recognizes 3 of a kind' do
      expect(HandAnalyzer.is_three_of_a_kind?(*@three_of_a_kind)).to eql(true)
    end

    it 'does not recognize a pair as 3 of a kind' do
      expect(HandAnalyzer.is_three_of_a_kind?(*@one_pair)).to eql(false)
    end

    it 'recognizes 2 pairs' do
      expect(HandAnalyzer.is_two_pair?(*@two_pair)).to eql(true)
    end

    it 'does not recognize 3 of a kind as 2 pairs' do
      expect(HandAnalyzer.is_two_pair?(*@three_of_a_kind)).to eql(false)
    end

    it 'recognizes 4 of a kind' do
      expect(HandAnalyzer.is_four_of_a_kind?(*@four_of_a_kind)).to eql(true)
    end

    it 'does not recognize 3 of a kind as 4 of a kind' do
      expect(HandAnalyzer.is_four_of_a_kind?(*@three_of_a_kind)).to eql(false)
    end

    it 'recognizes a fullhouse' do
      expect(HandAnalyzer.is_fullhouse?(*@full_house)).to eql(true)
    end
  end

end