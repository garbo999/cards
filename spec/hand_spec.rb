require 'hand'

RSpec.describe Hand do

  context 'basic Hand stuff' do
    it 'instantiates a hand' do
      @h = Hand.new
      expect(@h).to be
    end
  end
end
