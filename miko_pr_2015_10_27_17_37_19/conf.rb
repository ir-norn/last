#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

# ---------------------------
# リファレンス
# http://dxruby.osdn.jp/DXRubyReference/200953183937859.htm
#
# ----------- init ----------


#Window.load_icon "./icon/"
Window.caption = "ご注文はうさぎですか？"
Window.x       = 40
Window.y       = 40
#Window.width   = 640
#Window.height  = 480
Window.windowed = true
#Window.windowed = false
Window.fps = 60
# Window.frameskip?
# Window.frameskip=val
# Window.frameskip = true
Window.bgcolor = [0,0,0]
Window.create
