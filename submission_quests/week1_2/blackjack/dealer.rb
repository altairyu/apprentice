class Dealer < Player
  def initialize
    super
    @name = 'ディーラー'
  end

  # ループ用
  def under_17?(score)
    true if score <= 17
  end
end
