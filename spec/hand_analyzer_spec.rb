require 'handanalyzer'

RSpec.describe HandAnalyzer do 

  context 'analysis stuff' do

    it 'responds to the  class method :show_odds' do
      expect(HandAnalyzer).to respond_to(:show_odds)
    end
  end

end