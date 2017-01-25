require 'board'

RSpec.describe Board do

  it 'can create an empty board' do
    @b = Board.new(nil)
    expect(@b.cards).to eql([])
  end
  
end