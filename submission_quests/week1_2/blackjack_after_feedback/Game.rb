require_relative 'deck'
require_relative 'player'
require_relative 'dealer'

class Game
  def initialize
    puts 'ブラックジャックを開始します。'
    @deck = Deck.new
    @player = Player.new
    @dealer = Dealer.new
  end

  def start
    2.times do
      deal_and_add_score(@player)
      @player.hand.show(@player)
    end

    # ディーラーへの配布処理
    deal_and_add_score(@dealer)
    @dealer.hand.show(@dealer)

    deal_and_add_score(@dealer)
    puts 'ディーラーが引いた2枚目のカードはわかりません。'
  end

  def loop_player_turn
    loop do
      show_score(@player)
      puts 'カードを引きますか？（Y/N）'
      break unless @player.hit?

      deal_and_add_score(@player)
      @player.hand.show(@player)
      break if @player.hand.bust?(@player.score)
    end
    inform_bust if @player.score > 21
  end

  # ディーラーのスコアが17点未満ならループ
  def loop_dealer_turn
    # 2枚目のshow
    @dealer.hand.show(@dealer)

    while @dealer.under_17?(@dealer.score)
      deal_and_add_score(@dealer)
      @dealer.hand.show(@dealer)
      inform_dealer_bust if @dealer.hand.bust?(@dealer.score)
    end
  end

  # participant はゲーム参加者のインスタンスが入る
  def show_score(participant, phase = '現在の')
    puts "#{participant.name}の#{phase}得点は#{participant.score}です。"
  end

  def add_score(participant)
    participant.score += participant.hand.score(participant)
  end

  # 冗長性排除用のまとめメソッド
  def deal_and_add_score(participant)
    participant.hand.add(@deck.deal)
    add_score(participant)
  end

  def inform_bust
    puts 'バスト！！ 21点を超えてしまいました。あなたの負けです。'
    finish
  end

  def inform_dealer_bust
    puts 'ディーラーがバストしました。あなたの勝利です！！'
    finish
  end

  def show_final_scores
    show_score(@player, '')
    show_score(@dealer, '')
  end

  def show_result
    if @dealer.score > 21 || @player.score > @dealer.score
      puts 'おめでとうございます。あなたの勝ちです！'
    elsif @player.score < @dealer.score
      puts 'あなたの負けです。'
    else
      puts '引き分けです。'
    end
  end

  def finish
    puts 'ブラックジャックを終了します。'
    exit
  end
end
