require_relative 'hand'

class Player
  attr_reader :name, :hand
  attr_accessor :score

  def initialize
    @name = 'あなた'
    @score = 0
    @hand = Hand.new
  end

  # サブクラスでは使わない。blackjack_controllerから呼びたいのでpublicのままに。
  def hit?
    loop do
      input = gets.chomp.upcase
      return true if input == 'Y'
      return false if input == 'N'

      puts "入力が正しくありません。'Y' または 'N' を入力してください。"
    end
  end
end
