#coding:utf-8
#require "__dev/req" if $0 ==__FILE__
require"dxruby"
if $0 == __FILE__ \
#  and  (require "__dev/req")
  ARGV.replace [ 1 , 2 ]
  Dir.chdir File.dirname(File.expand_path(__FILE__))
  require "./lib/Count_lib_v2"
  require "./lib/chino_to_enum"
else
  require_relative "./lib/chino_to_enum"
  require_relative "./lib/Count_lib_v2"
end

# require "./__yuka_miko"
# __fead_inout_create_sub o

s = Sprite.new
s.x = 100
s.y = 100
s.image = Image.new(100, 100, C_WHITE)
s.visible = true
# s.collision = [0, 0, size - 1, size - 1]  # 当たり判定範囲
s.collision_enable = true
s.collision_sync = true
s.offset_sync = false # オフセット同期モードではSprite#center_x, Sprite#center_yに設定した位置がx/yの位置にくるように補正されます。
# s.vanished? # Sprite#vanishによって無効化されている場合に真を返します # Sprite.cleanで配列から削除されます。
class A < Sprite
  @@d = Image.new(100, 20, C_WHITE)
  def update
    Window.draw 300,200, @@d
  end
end

a = A.new

class Array_cycle
  attr_accessor :size , :seek
  def initialize size
    @size = size
    rewind
  end
  def rewind
    @aa = [*1..size].cycle
    @bb = [*-size..-1].reverse.cycle
  end
  def peek
    @aa.peek + @bb.peek
  end
  def next
    @seek = @aa.next
  end
  def prev
    @bb.next
  end
end
sstr =
Dir["*.rb"].each.each_with_index.map do |m,i|
  m
end
Font.default = Font.new(30)
# cc = Array_cycle.new sstr.size
# cc = Count_lib_v2.new( start: 1 , limit: sstr.size-1 , add: 1 )
cc = 0.step(sstr.size-1,1).cycle.chino_to_enum
(100*sstr.size.-(0)).times { cc.next }


class AAA
  class  << self
    attr_accessor :x
  end
end
AAA.x = 5


mouse = Sprite.new
mouse.collision = [0,0]



B_SHIFT_Z = ->{
  Input.key_down?(K_LSHIFT) && Input.key_push?(K_Z)
}

#    Input.set_repeat 30,5
# --------------------------------------------------------------------------------------
Window.loop do | o , node_self |
  exit if Input.keyPush? K_F9
#  p 4 if Input.keyPush? K_F

    if B_SHIFT_Z.call
      p 333
    end


  Input.keys.each do |m|
  case m
  when K_X
    p 2
  end
  end
#  Sprite.update [ s , a ]
#  Sprite.draw [ s , a]
#  Sprite.clean [ s , a]
#  Sprite.check [s , a]
#  s.draw

  mouse.x, mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

  if Input.keyPush? K_ESCAPE
    cc.rewind
  end
  if Input.keyPush? K_UP
    cc.prev
#    a.vanish
  end
  if Input.keyPush? K_DOWN
    cc.next
#    cc.rewind
#    s.vanish
  end
  sstr.each_with_index do |m,i|
    font_hash  = {}
    yh = 20

    if sstr[cc.peek].hash == sstr[i].hash
      font_hash = { :color => [100,200,200] }
      Window.draw_font(50 ,400 , cc.peek.to_s << sstr[cc.peek] , Font.default , font_hash )
      Window.draw_font(50 ,10 + (yh*i) , ">>" , Font.default , font_hash )
      Window.draw_font(100,10 + (yh*i) , m    , Font.default , font_hash )
    else
      Window.draw_font(100,10 + (yh*i) , m    , Font.default , font_hash )
    end
  end

end
