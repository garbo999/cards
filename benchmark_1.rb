require "benchmark"
require "./lib/card.rb"
require "./lib/carddeck.rb"
require "./lib/handanalyzer.rb"

n = 10000
time = Benchmark.measure do
  (1..n).each do
    cd = CardDeck.new
    board = cd.deal(5)
    hand = cd.deal(2)
    HandAnalyzer.evaluate(board, hand)
  end
end
puts "Time elapsed #{time*1000} milliseconds" # 490 ms




