require 'card'

RSpec.describe PlayingCard do 

  context 'basic PlayingCard stuff' do

    it 'instantiates a PlayingCard object' do
      @c = PlayingCard.new('A', 'Spades')
      expect(@c).to be
    end

    it 'creates a properly formed card' do
      @c = PlayingCard.new('A', 'Spades')
      expect(@c.suit).to eql('Spades')
      expect(@c.rank).to eql('A')
    end

    it 'rejects a malformed card' do
      expect {
       @c = PlayingCard.new('Z', 'Zoots') 
      }.to raise_error(ArgumentError)
    end

    it 'can output a card as an array' do
      @c = PlayingCard.new('A', 'Spades')
      expect(@c.to_ary).to eql(['A', 'Spades'])
    end

  end

end
