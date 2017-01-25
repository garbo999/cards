require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  context 'analysis stuff' do

    it 'responds to the class method :is_pair?' do
      expect(HandAnalyzer).to respond_to(:is_pair?)
    end

    it 'ranks an empty board and a pair as a pair' do
      expect(HandAnalyzer.is_pair?(Board.new([]), Hand.new( [Card.new("9", "Spades"), Card.new("9", "Hearts") ]) )).to eql(true)
    end

    it 'does not rank an empty board and two unpaired cards as a pair' do
      expect(HandAnalyzer.is_pair?(Board.new([]), Hand.new( [Card.new("9", "Spades"), Card.new("10", "Hearts") ]) )).to eql(false)
    end
  end

end