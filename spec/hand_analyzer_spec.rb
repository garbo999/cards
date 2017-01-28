require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  before :each do
    board = [Card.new("2", "Spades"), Card.new("3", "Hearts"), Card.new("7", "Spades"), Card.new("A", "Hearts"), Card.new("9", "Spades")]

    hand = [Card.new("10", "Spades"), Card.new("9", "Hearts") ]
    @one_pair = board, hand

    hand = [Card.new("10", "Spades"), Card.new("K", "Hearts") ]
    @high_card = board, hand

    hand = [Card.new("10", "Spades"), Card.new("K", "Spades") ]
    @flush = board, hand

    board = [Card.new("9", "Spades"), Card.new("3", "Spades"), Card.new("4", "Spades"), Card.new("A", "Hearts"), Card.new("5", "Spades")]
    hand = [Card.new("6", "Diamonds"), Card.new("2", "Hearts") ]
    @straight = board, hand

    board = [Card.new("A", "Spades"), Card.new("3", "Spades"), Card.new("4", "Spades"), Card.new("A", "Hearts"), Card.new("5", "Spades")]
    hand = [Card.new("7", "Diamonds"), Card.new("2", "Hearts") ]
    @straight_with_ace = board, hand

    board = [Card.new("2", "Diamonds"), Card.new("3", "Diamonds"), Card.new("4", "Diamonds"), Card.new("A", "Hearts"), Card.new("K", "Spades")]
    hand = [Card.new("5", "Diamonds"), Card.new("6", "Diamonds") ]
    @straight_flush = board, hand

    board = [Card.new("2", "Diamonds"), Card.new("2", "Clubs"), Card.new("4", "Diamonds"), Card.new("A", "Diamonds"), Card.new("K", "Spades")]
    hand = [Card.new("2", "Hearts"), Card.new("6", "Hearts") ]
    @three_of_a_kind = board, hand

    board = [Card.new("2", "Diamonds"), Card.new("2", "Clubs"), Card.new("4", "Diamonds"), Card.new("2", "Spades"), Card.new("K", "Spades")]
    hand = [Card.new("2", "Hearts"), Card.new("6", "Hearts") ]
    @four_of_a_kind = board, hand

    board = [Card.new("2", "Diamonds"), Card.new("10", "Clubs"), Card.new("4", "Diamonds"), Card.new("A", "Diamonds"), Card.new("K", "Spades")]
    hand = [Card.new("2", "Hearts"), Card.new("4", "Clubs") ]
    @two_pair = board, hand

    board = [Card.new("2", "Diamonds"), Card.new("2", "Clubs"), Card.new("4", "Diamonds"), Card.new("6", "Clubs"), Card.new("K", "Spades")]
    hand = [Card.new("2", "Hearts"), Card.new("6", "Hearts") ]
    @fullhouse = board, hand

  end

  context 'odds' do
    context 'basic stuff' do
      it 'responds to the class method :show_odds' do
        expect(HandAnalyzer).to respond_to(:show_odds)
      end

      it 'responds to the class method :winner' do
        expect(HandAnalyzer).to respond_to(:winner)
      end

      it 'tells us how many combinations there are' do
        board = []
        hand1 = [Card.new("10", "Spades"), Card.new("10", "Hearts") ]
        hand2 = [Card.new("9", "Spades"), Card.new("9", "Hearts") ]
        expect(HandAnalyzer.count_combinations(board, hand1, hand2)).to eql(1712304)
      end
    end

    context 'ordinary #winner handling' do
      it 'says that three of a kind beats one pair' do
        board = [Card.new("10", "Diamonds"), Card.new("3", "Diamonds"), Card.new("4", "Diamonds"), Card.new("A", "Hearts"), Card.new("K", "Spades")]
        hand1 = [Card.new("10", "Spades"), Card.new("10", "Hearts") ]
        hand2 = [Card.new("9", "Spades"), Card.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(true)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(false)
      end

      it 'says that a pair does not beat three of a kind' do
        board = [Card.new("2", "Diamonds"), Card.new("9", "Diamonds"), Card.new("4", "Diamonds"), Card.new("A", "Hearts"), Card.new("K", "Spades")]
        hand1 = [Card.new("10", "Spades"), Card.new("10", "Hearts") ]
        hand2 = [Card.new("9", "Spades"), Card.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(false)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(true)
      end

      xit 'shows some odds for higher vs lower pair' do 
        board = []
        hand1 = [Card.new("10", "Spades"), Card.new("10", "Hearts") ]
        hand2 = [Card.new("9", "Spades"), Card.new("9", "Hearts") ]
        expect(HandAnalyzer.show_odds(board, hand1, hand2)).to eql(0.8)
        # expected: 0.8
        # got: 0.8296634242517684
      end
    end

    context 'tie breaks by #winner' do
      it 'properly tie-breaks two straight flushes' do # A high straight flush (royal flush) vs K high straight flush
      board = [Card.new("10", "Diamonds"), Card.new("Q", "Diamonds"), Card.new("J", "Diamonds"), Card.new("A", "Hearts"), Card.new("K", "Diamonds")]
      hand1 = [Card.new("A", "Diamonds"), Card.new("10", "Hearts") ]
      hand2 = [Card.new("9", "Diamonds"), Card.new("2", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(true)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(false)
      end

      it 'properly tie-breaks two four of a kinds' do # 4 Js vs 4 10s
      board = [Card.new("10", "Hearts"), Card.new("Q", "Diamonds"), Card.new("J", "Clubs"), Card.new("J", "Spades"), Card.new("10", "Clubs")]
      hand1 = [Card.new("J", "Diamonds"), Card.new("J", "Hearts") ]
      hand2 = [Card.new("10", "Diamonds"), Card.new("10", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(true)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(false)
      end

      it 'properly tie-breaks two full houses' do # 3 Js + 2 8s vs 3 10s + 2 8s
      board = [Card.new("10", "Hearts"), Card.new("8", "Diamonds"), Card.new("J", "Clubs"), Card.new("8", "Spades"), Card.new("7", "Clubs")]
      hand1 = [Card.new("J", "Diamonds"), Card.new("J", "Hearts") ]
      hand2 = [Card.new("10", "Diamonds"), Card.new("10", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(true)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(false)
      end

      it 'properly tie-breaks two full houses, 2nd test' do # 3 Js + 2 9s vs 3 Js + 2 8s
      board = [Card.new("J", "Hearts"), Card.new("2", "Diamonds"), Card.new("J", "Clubs"), Card.new("J", "Spades"), Card.new("7", "Clubs")]
      hand1 = [Card.new("9", "Diamonds"), Card.new("9", "Hearts") ]
      hand2 = [Card.new("8", "Diamonds"), Card.new("8", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(true)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(false)
      end


    end

  end

  context 'evaluator' do
    it 'responds to the class method :evaluate' do
      expect(HandAnalyzer).to respond_to(:evaluate)
    end

    it 'recognises a high card' do
      expect(HandAnalyzer.evaluate(*@high_card)).to eql(:high_card)
    end

    it 'recognises a pair' do
      expect(HandAnalyzer.evaluate(*@one_pair)).to eql(:pair)
    end

    it 'recognises a two pair' do
      expect(HandAnalyzer.evaluate(*@two_pair)).to eql(:two_pair)
    end

    it 'recognises a three of a kind' do
      expect(HandAnalyzer.evaluate(*@three_of_a_kind)).to eql(:three_of_a_kind)
    end

    it 'recognises a straight' do
      expect(HandAnalyzer.evaluate(*@straight)).to eql(:straight)
    end
    it 'recognises a straight that starts with an Ace' do
      expect(HandAnalyzer.evaluate(*@straight_with_ace)).to eql(:straight)
    end
    it 'recognises a flush' do
      expect(HandAnalyzer.evaluate(*@flush)).to eql(:flush)
    end
    it 'recognises a full house' do
      expect(HandAnalyzer.evaluate(*@fullhouse)).to eql(:fullhouse)
    end
    it 'recognises a four of a kind' do
      expect(HandAnalyzer.evaluate(*@four_of_a_kind)).to eql(:four_of_a_kind)
    end
    it 'recognises a straight flush' do
      expect(HandAnalyzer.evaluate(*@straight_flush)).to eql(:straight_flush)
    end

  end

end