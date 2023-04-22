require_relative '../d'

class Deck
  def initialize
    @cards = generate_deck
  end

  def generate_deck
    cards = []
    Card::SUIT.each do |suit|
      Card::RANKS.each do |rank|
        cards << Card.new(suit, rank)
      end
    end
    cards.shuffle!
  end

  def deal
    @cards.pop
  end
end
