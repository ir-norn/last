#!ruby -Ks
require 'dxruby'
require_relative 'ayame'

module Audio
  @@bgm = nil
  @@bgs = nil
  @@next_bgm = nil
  @@next_bgs = nil
  @@next_fadetime_bgm = nil
  @@next_fadetime_bgm = nil
  @@me_play_state = nil
  @@se = []

  # bgm
  def self.play_bgm(filename, fadetime = 0)
    if @@bgm and @@bgm.playing? # BGM再生中なら停止と切り替え予約
      @@bgm.stop(fadetime)
      @@next_bgm = Ayame.new(filename)
      @@next_fadetime_bgm = fadetime
    else                        # 再生されてなければ再生する
      @@bgm = Ayame.new(filename)
      @@bgm.play(0, fadetime)
      @@next_bgm = nil
      @@next_fadetime_bgm = fadetime
    end
  end

  def self.stop_bgm(fadetime = 0)
    @@bgm.stop(fadetime)
  end

  def self.bgm
    @@bgm
  end

  # bgs
  def self.play_bgs(filename, fadetime = 0)
    if @@bgs and @@bgs.playing?
      @@bgs.stop(fadetime)
      @@next_bgs = Ayame.new(filename)
      @@next_fadetime_bgs = fadetime
    else
      @@bgs = Ayame.new(filename)
      @@bgs.play(0, fadetime)
      @@next_bgs = nil
      @@next_fadetime_bgs = fadetime
    end
  end

  def self.stop_bgs(fadetime = 0)
    @@bgs.stop(fadetime)
  end

  def self.bgs
    @@bgs
  end

  # me
  def self.play_me(filename)
    @@me_play_state = 1
    @@bgm.pause(1)
    @@me = Ayame.new(filename)
  end

  def self.me
    @@me
  end

  # se
  def self.play_se(filename, vol = 100)
    se =  Ayame.new(filename).play(1)
    se.set_volume(vol)
    @@se << se
  end

  def self.se
    @@se
  end

  def self.update
    Ayame.update

    if @@next_bgm
      if @@bgm.finished?
        @@bgm = @@next_bgm
        @@next_bgm = nil
        @@bgm.play(0, @@next_fadetime_bgm)
      end
    end

    if @@next_bgs
      if @@bgs.finished?
        @@bgs = @@next_bgs
        @@next_bgs = nil
        @@bgs.play(0, @@next_fadetime_bgs)
      end
    end

    if @@me_play_state == 1
      if @@bgm.pausing? # BGMが終わるまで待ってME再生
        @@me.play(1)
        @@me_play_state = 2
      end
    elsif @@me_play_state == 2
      if @@me.finished? # MEが終わるまで待ってBGM復活
        @@bgm.resume(1)
        @@me_play_state = nil
      end
    end

    @@se.delete_if {|s| s.finished?}
  end
end

if __FILE__ == $0

  # とりあえずbgm1再生
  Audio.play_bgm('bgm1.ogg',1)

  Window.loop do

    # フェードイン/アウトを1秒ずつでbgm2に切り替え
    if Input.key_push?(K_Z)
      Audio.play_bgm('bgm2.ogg', 1)
    end

    # bgs(環境音)再生
    if Input.key_push?(K_X)
      Audio.play_bgs('bgs.ogg')
    end

    # me(ジングル/短いチャイムみたいなの)再生
    if Input.key_push?(K_C)
      Audio.play_me('me.ogg')
    end

    # 効果音再生。多重再生可能。
    if Input.key_push?(K_V)
      Audio.play_se('se.ogg')
    end

    break if Input.key_push?(K_ESCAPE)

    Audio.update
  end

end
