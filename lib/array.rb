# I am adding a 'show_cards' method to Array in IRB to make it easier to display a hand
# It only makes sense when applied to an array of PlayingCard objects
class Array
  def show_cards
    new_array = []
    self.map {|c| new_array << c.to_s}
    return new_array
  end
end

