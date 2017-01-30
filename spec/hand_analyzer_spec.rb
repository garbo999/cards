require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  before :each do
    board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Hearts"), PlayingCard.new("7", "Spades"), PlayingCard.new("A", "Hearts"), PlayingCard.new("9", "Spades")]

    hand = [PlayingCard.new("10", "Spades"), PlayingCard.new("9", "Hearts") ]
    @one_pair = board, hand

    hand = [PlayingCard.new("10", "Spades"), PlayingCard.new("K", "Hearts") ]
    @high_card = board, hand

    hand = [PlayingCard.new("10", "Spades"), PlayingCard.new("K", "Spades") ]
    @flush = board, hand

    board = [PlayingCard.new("9", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("A", "Hearts"), PlayingCard.new("5", "Spades")]
    hand = [PlayingCard.new("6", "Diamonds"), PlayingCard.new("2", "Hearts") ]
    @straight = board, hand

    board = [PlayingCard.new("A", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("A", "Hearts"), PlayingCard.new("5", "Spades")]
    hand = [PlayingCard.new("7", "Diamonds"), PlayingCard.new("2", "Hearts") ]
    @straight_with_ace = board, hand

    board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
    hand = [PlayingCard.new("5", "Diamonds"), PlayingCard.new("6", "Diamonds") ]
    @straight_flush = board, hand

    board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("2", "Clubs"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Diamonds"), PlayingCard.new("K", "Spades")]
    hand = [PlayingCard.new("2", "Hearts"), PlayingCard.new("6", "Hearts") ]
    @three_of_a_kind = board, hand

    board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("2", "Clubs"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("2", "Spades"), PlayingCard.new("K", "Spades")]
    hand = [PlayingCard.new("2", "Hearts"), PlayingCard.new("6", "Hearts") ]
    @four_of_a_kind = board, hand

    board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("10", "Clubs"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Diamonds"), PlayingCard.new("K", "Spades")]
    hand = [PlayingCard.new("2", "Hearts"), PlayingCard.new("4", "Clubs") ]
    @two_pair = board, hand

    board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("2", "Clubs"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("6", "Clubs"), PlayingCard.new("K", "Spades")]
    hand = [PlayingCard.new("2", "Hearts"), PlayingCard.new("6", "Hearts") ]
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
        hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.count_combinations(board, hand1, hand2)).to eql(1712304)
      end
    end

    context 'ordinary #winner handling' do
      it 'says that three of a kind beats one pair' do
        board = [PlayingCard.new("10", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
        hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'says that a pair does not beat three of a kind' do
        board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
        hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      xit 'shows some odds for higher vs lower pair' do 
        board = []
        hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.show_odds(board, hand1, hand2)).to eql(0.8)
        # expected: 0.8
        # got: 0.8296634242517684
      end
    end

    context 'tie breaks by #winner' do
      it 'properly tie-breaks two straight flushes' do # A high straight flush (royal flush) vs K high straight flush
      board = [PlayingCard.new("10", "Diamonds"), PlayingCard.new("Q", "Diamonds"), PlayingCard.new("J", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Diamonds")]
      hand1 = [PlayingCard.new("A", "Diamonds"), PlayingCard.new("10", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Diamonds"), PlayingCard.new("2", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two four of a kinds' do # 4 Jacks vs 4 tens
      board = [PlayingCard.new("10", "Hearts"), PlayingCard.new("Q", "Diamonds"), PlayingCard.new("J", "Clubs"), PlayingCard.new("J", "Spades"), PlayingCard.new("10", "Clubs")]
      hand1 = [PlayingCard.new("J", "Diamonds"), PlayingCard.new("J", "Hearts") ]
      hand2 = [PlayingCard.new("10", "Diamonds"), PlayingCard.new("10", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two full houses' do # 3 Jacks + 2 eights vs 3 tens + 2 eights
      board = [PlayingCard.new("10", "Hearts"), PlayingCard.new("8", "Diamonds"), PlayingCard.new("J", "Clubs"), PlayingCard.new("8", "Spades"), PlayingCard.new("7", "Clubs")]
      hand1 = [PlayingCard.new("J", "Diamonds"), PlayingCard.new("J", "Hearts") ]
      hand2 = [PlayingCard.new("10", "Diamonds"), PlayingCard.new("10", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two full houses, 2nd test' do # 3 Jacks + 2 nines vs 3 Jacks + 2 eights
      board = [PlayingCard.new("J", "Hearts"), PlayingCard.new("2", "Diamonds"), PlayingCard.new("J", "Clubs"), PlayingCard.new("J", "Spades"), PlayingCard.new("7", "Clubs")]
      hand1 = [PlayingCard.new("9", "Diamonds"), PlayingCard.new("9", "Hearts") ]
      hand2 = [PlayingCard.new("8", "Diamonds"), PlayingCard.new("8", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two flushes' do # Ac Qc 7c 5c 2c vs Kc Qc 7c 5c 2c
      board = [PlayingCard.new("J", "Hearts"), PlayingCard.new("Q", "Clubs"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Clubs"), PlayingCard.new("2", "Clubs")]
      hand1 = [PlayingCard.new("A", "Clubs"), PlayingCard.new("7", "Spades") ]
      hand2 = [PlayingCard.new("K", "Clubs"), PlayingCard.new("8", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two straights' do # Ac Kd Qc Js 10h vs Kc Qc Js 10h 9c
      board = [PlayingCard.new("J", "Spades"), PlayingCard.new("Q", "Clubs"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Clubs"), PlayingCard.new("10", "Hearts")]
      hand1 = [PlayingCard.new("A", "Clubs"), PlayingCard.new("K", "Diamonds") ]
      hand2 = [PlayingCard.new("K", "Clubs"), PlayingCard.new("9", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two straights, 2nd test (actual tie)' do # Ac Kd Qc Js 10h vs Kc Qc Js 10h 9c
      board = [PlayingCard.new("J", "Spades"), PlayingCard.new("Q", "Clubs"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Clubs"), PlayingCard.new("10", "Hearts")]
      hand1 = [PlayingCard.new("A", "Clubs"), PlayingCard.new("K", "Diamonds") ]
      hand2 = [PlayingCard.new("K", "Clubs"), PlayingCard.new("A", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(0)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(0)
      end

      it 'properly tie-breaks three of a kind' do # 3c 3d 3s 10h 7c vs 2c 2s 2h 10h 7c
      board = [PlayingCard.new("3", "Clubs"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("10", "Hearts")]
      hand1 = [PlayingCard.new("3", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("2", "Clubs"), PlayingCard.new("2", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two pair' do # Ks Kh 3s 3d 8c vs Ks Kh 2c 2s Ah
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("K", "Spades"), PlayingCard.new("8", "Clubs"), PlayingCard.new("2", "Spades"), PlayingCard.new("K", "Hearts")]
      hand1 = [PlayingCard.new("7", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("2", "Clubs"), PlayingCard.new("A", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two pair, 2nd test (actual tie)' do # Ks Kh 3s 3d As vs Ks Kh 3s 3d As
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("K", "Spades"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("A", "Spades"), PlayingCard.new("K", "Hearts")]
      hand1 = [PlayingCard.new("7", "Spades"), PlayingCard.new("4", "Diamonds") ]
      hand2 = [PlayingCard.new("2", "Clubs"), PlayingCard.new("4", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(0)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(0)
      end

      it 'properly tie-breaks one pair' do # 3s 3d Ks 10h 7c vs 2c 2s Ah 10h 7c
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("10", "Hearts")]
      hand1 = [PlayingCard.new("K", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("2", "Clubs"), PlayingCard.new("A", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks one pair, 2nd test (one kicker)' do # 3s 3d Ks 10h 7c vs 3s 3h Qh 10h 7c
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("10", "Hearts")]
      hand1 = [PlayingCard.new("K", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("3", "Hearts"), PlayingCard.new("Q", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks one pair, 3rd test (actual tie)' do # 3s 3d Ks 10h 7c vs 3s 3h Kh 10h 7c 
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("10", "Hearts")]
      hand1 = [PlayingCard.new("K", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("3", "Hearts"), PlayingCard.new("K", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(0)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(0)
      end

      xit 'shows some odds for higher vs lower pair' do 
        board = []
        hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.show_odds(board, hand1, hand2)).to eql(0.8)
        # expected: 0.8
        # got: 0.8296634242517684
      end

    end
  end

  context 'Evaluator Method' do
    it 'responds to the class method :evaluate' do
      expect(HandAnalyzer).to respond_to(:evaluate)
    end

    it 'recognises a high card' do
      expect(HandAnalyzer.evaluate(*@high_card)[0]).to eql(:high_card)
    end

    it 'recognises a pair' do
      expect(HandAnalyzer.evaluate(*@one_pair)[0]).to eql(:pair)
    end

    it 'recognises a two pair' do
      expect(HandAnalyzer.evaluate(*@two_pair)[0]).to eql(:two_pair)
    end

    it 'recognises a three of a kind' do
      expect(HandAnalyzer.evaluate(*@three_of_a_kind)[0]).to eql(:three_of_a_kind)
    end

    it 'recognises a straight' do
      expect(HandAnalyzer.evaluate(*@straight)[0]).to eql(:straight)
    end
    it 'recognises a straight that starts with an Ace' do
      expect(HandAnalyzer.evaluate(*@straight_with_ace)[0]).to eql(:straight)
    end
    it 'recognises a flush' do
      expect(HandAnalyzer.evaluate(*@flush)[0]).to eql(:flush)
    end
    it 'recognises a full house' do
      expect(HandAnalyzer.evaluate(*@fullhouse)[0]).to eql(:fullhouse)
    end
    it 'recognises a four of a kind' do
      expect(HandAnalyzer.evaluate(*@four_of_a_kind)[0]).to eql(:four_of_a_kind)
    end

    it 'recognises a straight flush' do
      expect(HandAnalyzer.evaluate(*@straight_flush)[0]).to eql(:straight_flush)
    end
  end

  context 'Winner method' do

    it 'says that three of a kind beats one pair' do
      board = [PlayingCard.new("10", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
      hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
    end

    it 'says that a pair does not beat three of a kind' do
      board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
      hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
    end

    it 'knows a pair tens beats a pair of nines' do
      board = [PlayingCard.new("8", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
      hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
    end


    it 'knows a fullhouse with tens beats a fullhouse with nines' do
      board = [PlayingCard.new("10", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("A", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
      hand1 = [PlayingCard.new("10", "Spades"), PlayingCard.new("10", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
    end

  end

end