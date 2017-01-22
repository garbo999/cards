require 'card'

RSpec.describe Card do 

  context 'basic Card stuff' do

    it 'instantiates a Card object' do
      @c = Card.new('A', 'Spades')
      expect(@c).to be
    end

    it 'creates a properly formed card' do
      @c = Card.new('A', 'Spades')
      expect(@c.suit).to eql('Spades')
      expect(@c.rank).to eql('A')
    end

    it 'rejects a malformed card' do
      expect {
       @c = Card.new('Z', 'Zoots') 
      }.to raise_error(ArgumentError)
    end

  end

end
