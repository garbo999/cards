# Texas Holdem Hand Analyzer

## Description
The idea here is to develop a 'naive' hand analyzer using Ruby and RSpec. The emphasis is on the test spec created with RSpec.

## Goal
The `ruby-poker` gem (https://github.com/robolson/ruby-poker) does a good job of evaluating poker hands. What we want here is a way to analyze the odds of specific hands like this:

Example 1:
```ruby
board = [] # preflop
hand1 = [PlayingCard.new("T", "Spades"), PlayingCard.new("T", "Hearts") ]
hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
HandAnalyzer.show_odds(board, hand1, hand2) # => hand1_wins, ties = [0.8240254067034826, 0.005806211981050094]
```

The code above creates two hands (a pair of Ts vs. a lower pair of 9s). These odds are important to know in Texas Holdem. We calculate the odds with a full simulation. This means evaluating 1712304 hands (48 remaining cards in the deck in combinations of 5).

Example 2:
```ruby
board = []
hand1 = [PlayingCard.new("A", "Spades"), PlayingCard.new("K", "Hearts") ]
hand2 = [PlayingCard.new("9", "Spades"), PlayingCard.new("9", "Hearts") ]
HandAnalyzer.show_odds(board, hand1, hand2)  # => hand1_wins, ties = [0.44903416683018904, 0.004713532176529402]
```

## Development process
We use test-driven development (TDD). We move forward by writing individual tests to incrementally reach the goal described above.

## TO DO
- Increase speed compared to the naive hand evaluation solution
- Handle other situations besides preflop
- Attempt to analyze and quantify how long streaks of luck can occur in Texas Holdem
