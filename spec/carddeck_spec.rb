require 'carddeck'

RSpec.describe CardDeck do

  before :each do
    @cd = CardDeck.new
  end

  context 'basic CardDeck stuff' do

    it 'instantiates a CardDeck object' do
      #@cd = CardDeck.new
      expect(@cd).to be
    end

    it 'can convert the card deck to an array' do
      expect(@cd.to_ary.class).to eql(Array)
    end

    it 'has 52 cards when newly created' do
      expect(@cd.count_cards).to eql(52)
    end

    it 'responds to the print_whole_deck method' do
      expect(@cd).to respond_to(:print_whole_deck)
    end

    it 'creates two new decks with same number of cards' do
      @cd2 = CardDeck.new
      expect(@cd.count_cards).to eql(@cd2.count_cards)
    end

    it 'creates two new decks in identical order' do
      @cd2 = CardDeck.new
      expect(@cd.to_ary).to eql(@cd2.to_ary)
    end

  end

  context 'shuffling' do
    it 'responds to the shuffle! method' do
      expect(@cd).to respond_to(:shuffle!)
    end

    it 'appears to randomly shuffle the deck' do
      # we shuffle two different decks and compare the two arrays of cards
      @cd2 = CardDeck.new
      @cd.shuffle!
      @cd2.shuffle!
      expect(@cd.to_ary).to_not eql(@cd2.to_ary)      
    end
  end

  context 'dealing' do
    it 'responds to the deal method' do
      expect(@cd).to respond_to(:deal)
    end

    it 'deals a single card by default' do
      card = @cd.deal
      expect(card.class).to eql(Array)
      expect(card.count).to eql(1)
    end

    it 'deals the last card from the (unshuffled) deck' do
      card = @cd.deal
      expect(card[0].rank).to eql('K')
      expect(card[0].suit).to eql('Clubs')
    end

    it 'deals 5 cards when so requested' do
      cards = @cd.deal(5)
      expect(cards.count).to eql(5)
    end

    it 'does not deal more than 52 cards' do
      expect {
        @cd.deal(53)
      }.to raise_error(NotEnoughCardsError)
    end
  end

  context 'statistics' do
    it 'deals pairs in a 2-card hand at a ratio of approx. 1/17' do

      cnt = 0
      X = 1000000
      X.times do |i|
        begin
          h = @cd.deal(2)
        rescue NotEnoughCardsError
          @cd = CardDeck.new
          @cd.shuffle!
          h = @cd.deal(2)
        end
        if h[0].rank == h[1].rank
          cnt = cnt + 1
        end
      end
      ratio = X/cnt.to_f
      seventeen = 17.to_f
      percent_diff = (seventeen - ratio).abs / seventeen * 100
      puts "percent_diff=#{percent_diff}"
      max_percentage = 1 # tolerate max 1% difference
      
      expect(percent_diff).to be < (max_percentage)

    end
  end

end
