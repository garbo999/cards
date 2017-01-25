require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  context 'analysis stuff' do

    it 'responds to the class method :is_pair?' do
      expect(HandAnalyzer).to respond_to(:is_pair?)
    end
  end

end