#!ruby -Ks
require 'dxruby'
require_relative 'ayame'

filename = Window.openFilename([["ｽﾍﾞﾃﾉﾌｧｲﾙ(*.*)", "*.*"]], "再生する音楽ファイルを選択")

sound = Ayame.new(filename)
#data = ""
#open(filename, "rb") do |fh|
#  data = fh.read(File.size(filename))
#end

#sound = Ayame.load_from_memory(data)

font = Font.new(32)

#sound.prefetch
#sound.predecode

Window.loop do
  sound.play(-1, 1) if Input.keyPush?(K_Z)
  sound.stop(1) if Input.keyPush?(K_X)
  sound.pause(1) if Input.keyPush?(K_C)
  sound.resume(1) if Input.keyPush?(K_V)
  sound.set_pan(-100, 2) if Input.keyPush?(K_A)
  sound.set_pan(0, 2) if Input.keyPush?(K_S)
  sound.set_pan(100, 2) if Input.keyPush?(K_D)
  sound.set_volume(0, 2) if Input.keyPush?(K_Q)
  sound.set_volume(100, 2) if Input.keyPush?(K_W)

  Window.drawFont(0, 0, "Z・・・再生", font)
  Window.drawFont(0, 32, "X・・・停止", font)
  Window.drawFont(0, 64, "A・・・パンを左", font)
  Window.drawFont(0, 96, "S・・・パンを中央", font)
  Window.drawFont(0, 128, "D・・・パンを右", font)
  Window.drawFont(0, 160, "Q・・・ボリューム０％", font)
  Window.drawFont(0, 192, "W・・・ボリューム１００％", font)
  Window.drawFont(0, 224, "C・・・ポーズ", font)
  Window.drawFont(0, 256, "V・・・再開", font)

  Window.draw_font(0, 300, "fading? : " + sound.fading?.to_s, font)
  Window.draw_font(0, 332, "pan : " + sound.get_pan.to_s, font)
  Window.draw_font(0, 364, "volume : " + sound.get_volume.to_s, font)
  Window.draw_font(200, 300, "playing? : " + sound.playing?.to_s, font)
  Window.draw_font(200, 332, "finished? : " + sound.finished?.to_s, font)
  Window.draw_font(200, 364, "pausing? : " + sound.pausing?.to_s, font)

  Ayame.update

  break if Input.key_push?(K_ESCAPE)
end

sound.dispose


