require "benchmark"
require "./lib/card.rb"
require "./lib/carddeck.rb"
require "./lib/hand.rb"
require "./lib/board.rb"
require "./lib/handanalyzer.rb"

n = 10000
time = Benchmark.measure do
  (1..n).each do
    cd = CardDeck.new
    board = Board.new(cd.deal(5))
    hand = Hand.new(cd.deal(2))
    HandAnalyzer.evaluate(board, hand)
  end
end
puts "Time elapsed #{time*1000} milliseconds" # 490 ms




