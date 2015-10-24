# -*- encoding: UTF-8 -*-

require "__tewi/req"  if $0 ==__FILE__

if $0 ==__FILE__
  require "ostruct"
  require 'dxruby'
end
#

# ----------- init --------
Window.caption = "ご注文はうさぎですか？"
Window.x       = 40
Window.y       = 0
#Window.width   = 640
#Window.height  = 480
# true --- window mode --------------- false --- full screen mode ---------
Window.windowed = true
#Window.windowed = false
Window.fps = 60
#
# Window.frameskip?
# Window.frameskip=val
# true で 1フレームだけ描画処理を省く
# Window.frameskip = true
Window.bgcolor = [0,0,0]
Window.create

# debug mode
class DEBUG_CODE_CLASS
  attr_accessor :MAIN_LOOP , :STATIC_LOGIC, :SCENE_FLAG
  def initialize
    @STATIC_LOGIC_var = ->{_={};->{ _[caller.to_s] ? false : _[caller.to_s] = true }}.call
  end
  def STATIC_LOGIC
   @STATIC_LOGIC_var.call
  end
end
$__DEBUG_CODE = DEBUG_CODE_CLASS.new
$__DEBUG_CODE.MAIN_LOOP  = true
$__DEBUG_CODE.SCENE_FLAG = true
