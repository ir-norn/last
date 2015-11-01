require 'dxruby'
require 'pp'

p render_target =  RenderTarget.new(100,100,[200,200,150])


old_keys = []

# キー定数に定義された値と、そのキーの文字(定数から抽出)を関連付けるハッシュを生成する
keys_hash = {}
DXRuby.constants.each do |sym|
#keys_hash[DXRuby.const_get(sym)] = sym
  if sym =~ /K_/
    keys_hash[DXRuby.const_get(sym)] = sym
  end
end



# 速すぎると文字が見えないので遅くする
Window.fps = 10

Window.loop  do
  exit                       if Input.keyPush? K_F9
  # 前回のフレームとの差を取って新規に押されたキーの配列を生成する
  keys = Input.keys - old_keys
  keys.each.with_index do |s, i|
    p keys_hash[s]
  end
  # 今回のキー一覧を保存しておく
  old_keys = Input.keys
next

  # 新規に押されたキーを表示する
  keys.each.with_index do |s, i|
    if keys_hash[s]
      Window.draw_font(0, i * 24, keys_hash[s].to_s, Font.default)
    end
  end
end
