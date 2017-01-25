require 'hand'

RSpec.describe Hand do

  before :each do
    @cd = CardDeck.new
  end

  context 'basic Hand stuff' do

    it 'instantiates a hand' do
      h = Hand.new(@cd.deal(5))
      expect(h).to be
    end

    it 'has 5 cards if we deal it 5 cards' do
      h = Hand.new(@cd.deal(5))
      expect(h.cards.count).to eql(5)
    end

    it 'can be created with 2 specific cards' do
      h = Hand.new(@cd.deal_specific(Card.new('10', 'Clubs'), Card.new('10', 'Diamonds')))
      expect(h.cards.count).to eql(2)
      expect(h.cards[0].rank).to eql('10')
      expect(h.cards[0].suit).to eql('Clubs')
      expect(h.cards[1].rank).to eql('10')
      expect(h.cards[1].suit).to eql('Diamonds')
    end
  end
end
