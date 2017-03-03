require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  before :each do
    board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Hearts"), PlayingCard.new("7", "Spades"), PlayingCard.new("A", "Hearts"), PlayingCard.new("9", "Spades")]

    hand = [PlayingCard.new("T", "Spades"), PlayingCard.new("9", "Hearts") ]
    @one_pair = board, hand

    hand = [PlayingCard.new("T", "Spades"), PlayingCard.new("K", "Hearts") ]
    @high_card = board, hand

    hand = [PlayingCard.new("T", "Spades"), PlayingCard.new("K", "Spades") ]
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

    board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("T", "Clubs"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Diamonds"), PlayingCard.new("K", "Spades")]
    hand = [PlayingCard.new("2", "Hearts"), PlayingCard.new("4", "Clubs") ]
    @two_pair = board, hand

    board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("2", "Clubs"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("6", "Clubs"), PlayingCard.new("K", "Spades")]
    hand = [PlayingCard.new("2", "Hearts"), PlayingCard.new("6", "Hearts") ]
    @fullhouse = board, hand

  end

  context 'basic stuff' do
    it 'responds to the class method :show_odds' do
      expect(HandAnalyzer).to respond_to(:show_odds)
    end

    it 'responds to the class method :winner' do
      expect(HandAnalyzer).to respond_to(:winner)
    end

    it 'responds to the class method :evaluate' do
      expect(HandAnalyzer).to respond_to(:evaluate)
    end

   it 'tells us how many combinations there are' do
      board = []
      hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.count_combinations(board, hand1, hand2)).to eql(1712304)
    end

    xit 'shows some odds for higher vs lower pair' do 
      board = []
      hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.show_odds(board, hand1, hand2)).to eql([0.8240254067034826, 0.005806211981050094])
      # 3mar17:  => [0.8240254067034826, 0.005806211981050094] (I think this is correct)
      # corresponds to result from this site: http://www.cardplayer.com/poker-tools/odds-calculator/texas-holdem
    end

    it 'shows some odds for higher vs lower pair, 2nd test' do 
      board = []
      hand1 = [PlayingCard.new("A", "Spades"), PlayingCard.new("K", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.show_odds(board, hand1, hand2)).to eql([0.44903416683018904, 0.004713532176529402])
      # 3mar17:  => [0.44903416683018904, 0.004713532176529402] (I think this is correct)
      # corresponds to result from this site: http://www.cardplayer.com/poker-tools/odds-calculator/texas-holdem
    end
  end

  context '#evaluate method' do
    context 'recognizing hands' do
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

    context 'tie breaks' do
      it 'returns :high_card and all five cards sorted in case of a high-card hand' do
        # board + hand = ["2 of Spades", "3 of Hearts", "7 of Spades", "A of Hearts", "9 of Spades", "T of Spades", "K of Hearts"]
        expect(HandAnalyzer.evaluate(*@high_card)).to eql([:high_card, [12, 11, 8, 7, 5]]) # A K T 9 7
      end
    end

    context 'problematic edge cases' do
      it 'returns proper values for 7 card board with 4 of a kind and 3 of a kind' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("2", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("2", "Clubs")]
        hand1 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:four_of_a_kind, [0, 7]]) 
      end

      it 'returns proper values for 7 card board with 4 of a kind and pair, 2nd test' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("2", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("2", "Clubs")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:four_of_a_kind, [0, 8]]) 
      end

      it 'handles flush situation, 1st test' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("5", "Spades"), PlayingCard.new("T", "Diamonds")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:flush, [8, 3, 2, 1, 0]]) 
      end

      it 'handles flush situation, 2nd test' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("5", "Spades"), PlayingCard.new("T", "Diamonds")]
        hand1 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:flush, [7, 3, 2, 1, 0]]) 
      end

      it 'handles two-pair situation, 1st test' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("3", "Hearts")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        #hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:two_pair, [8, 1, 2]]) 
      end

      it 'handles two-pair situation, 2nd test' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("3", "Hearts")]
        hand1 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:two_pair, [7, 1, 2]]) 
      end

      it 'handles full-house situation, 1st test' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("3", "Hearts"), PlayingCard.new("2", "Diamonds")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:fullhouse, [0, 8]]) 
      end

      it 'handles full-house situation, 2nd test' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("3", "Hearts"), PlayingCard.new("2", "Diamonds")]
        hand1 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:fullhouse, [0, 7]]) 
      end

      it 'handles full-house situation, 3rd test' do # "2s 3s 2h Td 2d Ts Th" --> Td Ts Th 2s 2h
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("2", "Diamonds")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:fullhouse, [8, 0]]) 
      end

      it 'handles full-house situation, 4th test' do # "2s 3s 2h 3h 3d Ts Th" --> 3s 3h 3d Td Ts
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("3", "Hearts"), PlayingCard.new("3", "Diamonds")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        expect(HandAnalyzer.evaluate(board, hand1)).to eql([:fullhouse, [1, 8]]) 
      end
    
    end
  end

  context '#winner method' do

    context 'ordinary winners' do
      it 'says that three of a kind beats one pair' do
        board = [PlayingCard.new("T", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'says that a pair does not beat three of a kind' do
        board = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      it 'says that two pair LOSES to three of a kind' do
        board = []
        hand1 = [PlayingCard.new("3", "Diamonds"), PlayingCard.new("J", "Spades"), PlayingCard.new("J", "Clubs"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades")]
        hand2 = [PlayingCard.new("A", "Spades"), PlayingCard.new("A", "Clubs"), PlayingCard.new("A", "Diamonds"), PlayingCard.new("6", "Hearts"), PlayingCard.new("K", "Clubs")]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      it 'knows a pair tens beats a pair of nines' do
        board = [PlayingCard.new("8", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'knows a fullhouse with tens beats a fullhouse with nines' do
        board = [PlayingCard.new("T", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("A", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'knows a straight beats 3 of a kind' do # "7s 8d Td 6d 9c" vs "6d 9d Tc 9s 9h"
      board = []
      hand1 = [PlayingCard.new("7", "Spades"), PlayingCard.new("8", "Diamonds"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("6", "Diamonds"), PlayingCard.new("9", "Clubs") ]
      hand2 = [PlayingCard.new("6", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("T", "Clubs"), PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'knows a fullhouse beats Ace high card' do
        board = []
        hand1 = [PlayingCard.new("9", "Spades"), PlayingCard.new("A", "Clubs"), PlayingCard.new("8", "Diamonds"), PlayingCard.new("Q", "Hearts"), PlayingCard.new("6", "Spades")  ]
        hand2 = [PlayingCard.new("5", "Diamonds"), PlayingCard.new("3", "Hearts"), PlayingCard.new("5", "Clubs"), PlayingCard.new("5", "Spades"), PlayingCard.new("3", "Spades") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      it 'handles a problem straight flush situation (straight and flush but not straight-flush)' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("5", "Spades"), PlayingCard.new("6", "Hearts")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'handles a problem flush situation' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("5", "Spades"), PlayingCard.new("T", "Diamonds")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'handles a problem two-pair  situation' do
        board = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("3", "Hearts")]
        hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
        hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
        expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
        expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

# error I found in ruby-poker gem
=begin
"Ah Kd Ad Kc Ac Ts Th"
"Full house"
"Ah Kd Ad Kc Ac 9s 9h"
"Full house"
"our result = 0"
"their result = 1"
=end

# another such error
=begin
"Jh 6d Jd 6c Jc Ts Th"
"Full house"
"Jh 6d Jd 6c Jc 9s 9h"
"Full house"
"our result = 1"
"their result = 0"
=end

    end

    context 'tie breaks' do
      it 'properly tie-breaks two straight flushes' do # A high straight flush (royal flush) vs K high straight flush
      board = [PlayingCard.new("T", "Diamonds"), PlayingCard.new("Q", "Diamonds"), PlayingCard.new("J", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Diamonds")]
      hand1 = [PlayingCard.new("A", "Diamonds"), PlayingCard.new("T", "Hearts") ]
      hand2 = [PlayingCard.new("9", "Diamonds"), PlayingCard.new("2", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two four of a kinds' do # 4 Jacks vs 4 tens
      board = [PlayingCard.new("T", "Hearts"), PlayingCard.new("Q", "Diamonds"), PlayingCard.new("J", "Clubs"), PlayingCard.new("J", "Spades"), PlayingCard.new("T", "Clubs")]
      hand1 = [PlayingCard.new("J", "Diamonds"), PlayingCard.new("J", "Hearts") ]
      hand2 = [PlayingCard.new("T", "Diamonds"), PlayingCard.new("T", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two full houses' do # 3 Jacks + 2 eights vs 3 tens + 2 eights
      board = [PlayingCard.new("T", "Hearts"), PlayingCard.new("8", "Diamonds"), PlayingCard.new("J", "Clubs"), PlayingCard.new("8", "Spades"), PlayingCard.new("7", "Clubs")]
      hand1 = [PlayingCard.new("J", "Diamonds"), PlayingCard.new("J", "Hearts") ]
      hand2 = [PlayingCard.new("T", "Diamonds"), PlayingCard.new("T", "Spades") ]
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

      it 'properly tie-breaks two flushes, 2nd test' do # Js 3s Ks 6s Qs vs 8d 6d 3d Kd 2d
      board = []
      hand1 = [PlayingCard.new("J", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("K", "Spades"), PlayingCard.new("6", "Spades"), PlayingCard.new("Q", "Spades")]
      hand2 = [PlayingCard.new("8", "Diamonds"), PlayingCard.new("6", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("K", "Diamonds"), PlayingCard.new("2", "Diamonds")]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two flushes, 3rd test' do # Js 3s Ks 6s Qs vs 8d 6d 3d Kd 2d
      board = []
      hand1 = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("A", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("Q", "Diamonds")]
      hand2 = [PlayingCard.new("A", "Spades"), PlayingCard.new("9", "Spades"), PlayingCard.new("Q", "Spades"), PlayingCard.new("6", "Spades"), PlayingCard.new("T", "Spades")]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      it 'properly tie-breaks two straights' do # Ac Kd Qc Js Th vs Kc Qc Js Th 9c
      board = [PlayingCard.new("J", "Spades"), PlayingCard.new("Q", "Clubs"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Clubs"), PlayingCard.new("T", "Hearts")]
      hand1 = [PlayingCard.new("A", "Clubs"), PlayingCard.new("K", "Diamonds") ]
      hand2 = [PlayingCard.new("K", "Clubs"), PlayingCard.new("9", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks two straights, 2nd test (actual tie)' do # Ac Kd Qc Js Th vs Kc Qc Js Th 9c
      board = [PlayingCard.new("J", "Spades"), PlayingCard.new("Q", "Clubs"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Clubs"), PlayingCard.new("T", "Hearts")]
      hand1 = [PlayingCard.new("A", "Clubs"), PlayingCard.new("K", "Diamonds") ]
      hand2 = [PlayingCard.new("K", "Clubs"), PlayingCard.new("A", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(0)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(0)
      end

      it 'properly tie-breaks three of a kind' do # 3c 3d 3s Th 7c vs 2c 2s 2h Th 7c
      board = [PlayingCard.new("3", "Clubs"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("T", "Hearts")]
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

      it 'properly tie-breaks one pair' do # 3s 3d Ks Th 7c vs 2c 2s Ah Th 7c
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("T", "Hearts")]
      hand1 = [PlayingCard.new("K", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("2", "Clubs"), PlayingCard.new("A", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks one pair, 2nd test (one kicker)' do # 3s 3d Ks Th 7c vs 3s 3h Qh Th 7c
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("T", "Hearts")]
      hand1 = [PlayingCard.new("K", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("3", "Hearts"), PlayingCard.new("Q", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks one pair, 3rd test (actual tie)' do # 3s 3d Ks Th 7c vs 3s 3h Kh Th 7c 
      board = [PlayingCard.new("3", "Spades"), PlayingCard.new("2", "Spades"), PlayingCard.new("7", "Clubs"), PlayingCard.new("5", "Hearts"), PlayingCard.new("T", "Hearts")]
      hand1 = [PlayingCard.new("K", "Spades"), PlayingCard.new("3", "Diamonds") ]
      hand2 = [PlayingCard.new("3", "Hearts"), PlayingCard.new("K", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(0)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(0)
      end

      it 'properly tie-breaks one pair, 4th test (two kickers)' do # 4s Td 4c 2s 3c" vs "9c 4c 4d 2c Th !!! 4c twice
      board = []
      hand1 = [PlayingCard.new("4", "Spades"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("4", "Hearts"), PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Clubs")]
      hand2 = [PlayingCard.new("9", "Clubs"), PlayingCard.new("4", "Clubs"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("2", "Clubs"), PlayingCard.new("T", "Hearts")]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      it 'properly tie-breaks high cards, 1st test' do # "As 8s Ts 2h 9s" vs "As 8h Qh Td 9h"
      board = []
      hand1 = [PlayingCard.new("A", "Spades"), PlayingCard.new("8", "Spades"), PlayingCard.new("T", "Spades"), PlayingCard.new("2", "Hearts"), PlayingCard.new("9", "Spades") ]
      hand2 = [PlayingCard.new("A", "Hearts"), PlayingCard.new("8", "Hearts"), PlayingCard.new("Q", "Hearts"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("9", "Hearts") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      it 'properly tie-breaks high cards, 2nd test' do # "Qs 5s Kh 2c Jd" vs "4d 6s Js Td Ks"
      board = []
      hand1 = [PlayingCard.new("Q", "Spades"), PlayingCard.new("5", "Spades"), PlayingCard.new("K", "Hearts"), PlayingCard.new("2", "Clubs"), PlayingCard.new("J", "Diamonds") ]
      hand2 = [PlayingCard.new("4", "Diamonds"), PlayingCard.new("6", "Spades"), PlayingCard.new("J", "Spades"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("K", "Spades") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks high cards, 3rd test' do # "5h 9d 4s Th As" vs "9c 7s Jd 8h Ad"
      board = []
      hand1 = [PlayingCard.new("5", "Hearts"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Spades"), PlayingCard.new("T", "Hearts"), PlayingCard.new("A", "Spades") ]
      hand2 = [PlayingCard.new("9", "Clubs"), PlayingCard.new("7", "Spades"), PlayingCard.new("J", "Diamonds"), PlayingCard.new("8", "Hearts"), PlayingCard.new("A", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(2)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(1)
      end

      it 'properly tie-breaks high cards, 4th test (3 cards equal)' do # "5h 9d 4s Th As" vs "5c 9s 3d Td Ad"
      board = []
      hand1 = [PlayingCard.new("5", "Hearts"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Spades"), PlayingCard.new("T", "Hearts"), PlayingCard.new("A", "Spades") ]
      hand2 = [PlayingCard.new("4", "Clubs"), PlayingCard.new("9", "Spades"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("A", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks high cards, 5th test (4 cards equal)' do # "5h 9d 4s Th As" vs "5c 9s 3d Td Ad"
      board = []
      hand1 = [PlayingCard.new("5", "Hearts"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Spades"), PlayingCard.new("T", "Hearts"), PlayingCard.new("A", "Spades") ]
      hand2 = [PlayingCard.new("5", "Clubs"), PlayingCard.new("9", "Spades"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("A", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(1)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(2)
      end

      it 'properly tie-breaks high cards, 6th test (true tie)' do # "5h 9d 4s Th As" vs "5c 9s 4d Td Ad"
      board = []
      hand1 = [PlayingCard.new("5", "Hearts"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Spades"), PlayingCard.new("T", "Hearts"), PlayingCard.new("A", "Spades") ]
      hand2 = [PlayingCard.new("5", "Clubs"), PlayingCard.new("9", "Spades"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("A", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(0)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(0)
      end

      it 'properly tie-breaks pairs' do # "4s Td 4c 2s 3c4s Td 4c 2s 3c" vs "9c 4c 4d 2c Th"
      board = []
      hand1 = [PlayingCard.new("5", "Hearts"), PlayingCard.new("9", "Diamonds"), PlayingCard.new("4", "Spades"), PlayingCard.new("T", "Hearts"), PlayingCard.new("A", "Spades") ]
      hand2 = [PlayingCard.new("5", "Clubs"), PlayingCard.new("9", "Spades"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("T", "Diamonds"), PlayingCard.new("A", "Diamonds") ]
      expect(HandAnalyzer.winner(board, hand1, hand2)).to eql(0)
      expect(HandAnalyzer.winner(board, hand2, hand1)).to eql(0)
      end

    end
  end

  context 'private methods' do
    # note: interesting discussion on wisdom of testing private methods: https://mixandgo.com/blog/3-ways-of-testing-private-methods-in-rails
    context '#is_straight? method' do
      it 'properly recognises a straight, 1st test' do
        rank_array = [1,1,1,1,1,0,0,0,0,0,0,0,0] # straight = 2, 3, 4, 5, 6
        expect(HandAnalyzer.send(:is_straight?, rank_array)).to eq([true, 4])
      end
      it 'properly recognises a non-straight, 2nd test' do
        rank_array = [1,1,1,1,0,1,0,0,0,0,0,0,0] # not a straight = 2, 3, 4, 5, 7
        expect(HandAnalyzer.send(:is_straight?, rank_array)).to eq([false, nil])
      end
      it 'properly recognises a straight, 3rd test' do
        rank_array = [1,1,1,1,0,0,0,0,0,0,0,0,1] # traight = A, 2, 3, 4, 5 (Ace is at end!)
        expect(HandAnalyzer.send(:is_straight?, rank_array)).to eq([true, 3])
      end
      it 'properly recognises a straight, 4th test' do
        # here we have 7 cards and three possible straights, so we want the highest possible straight
        # this test fails initially
        rank_array = [1,1,1,1,1,1,1,0,0,0,0,0,0] # highest straight = 4, 5, 6, 7, 8
        expect(HandAnalyzer.send(:is_straight?, rank_array)).to eq([true, 6])
      end
      it 'properly recognises a straight, 5th test' do
        rank_array = [0,1,1,1,1,1,0,0,0,0,0,0,0] # straight = 3, 4, 5, 6, 7
        expect(HandAnalyzer.send(:is_straight?, rank_array)).to eq([true, 5])
      end
    end

    context '#straight_flush? method' do
      it 'properly recognises a straight flush, 1st test' do
        cards = [PlayingCard.new("2", "Diamonds"), PlayingCard.new("3", "Diamonds"), PlayingCard.new("4", "Diamonds"), PlayingCard.new("5", "Diamonds"), PlayingCard.new("6", "Diamonds"), PlayingCard.new("A", "Hearts"), PlayingCard.new("K", "Spades")]
        #hand = [PlayingCard.new("5", "Diamonds"), PlayingCard.new("6", "Diamonds") ]
        expect(HandAnalyzer.send(:is_straight_flush?, cards)).to eq([true, 4])

      end
      it 'properly recognises a straight flush, 2nd test' do
        #cards --> ["2 of Spades", "3 of Spades", "4 of Spades", "5 of Spades", "6 of Hearts", "9 of Spades", "9 of Hearts"]
        cards = [PlayingCard.new("2", "Spades"), PlayingCard.new("3", "Spades"), PlayingCard.new("4", "Spades"), PlayingCard.new("5", "Spades"), PlayingCard.new("6", "Hearts"), PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts")]
        expect(HandAnalyzer.send(:is_straight_flush?, cards)).to eq([false, nil])
      end

    end

  end
end