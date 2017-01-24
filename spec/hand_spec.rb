require 'hand'

RSpec.describe Hand do

  before :each do
    @h = Hand.new
  end

  context 'basic Hand stuff' do

    xit 'instantiates a hand' do
      expect(@h).to be
    end

    xit 'has 5 cards by default' do
      expect(@h.count).to eql(5)
    end

  end
end
