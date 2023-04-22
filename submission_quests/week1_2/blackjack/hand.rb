require_relative '../d'

class Hand
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add(card)
    @cards << card
  end

  def show(participant)
    puts "#{participant.name}が引いた#{@cards.length}枚目のカードは#{@cards.last.suit}の#{@cards.last.rank}"
  end

  def score(participant)
    case @cards.last.rank
    when 'J', 'Q', 'K'
      10
    when 'A'
      calc_ace_score(participant)
    else
      @cards.last.rank.to_i
    end
  end

  def calc_ace_score(participant)
    if 11 + participant.score <= 21
      11
    else
      1
    end
  end

  def bust?(score)
    true if score > 21
  end
end
