#coding:utf-8
#require "__dev/req" if $0 ==__FILE__
require"dxruby"
if $0 == __FILE__
#  Dir.chdir File.dirname(File.expand_path(__FILE__))
  ARGV.replace [ 1 , 2 ]
end

# require "./__yuka_miko"
# require "./count_limit_lib"
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

class My_cycle
  attr_accessor :size
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
    @bb.next
  end
  def prev
    @aa.next
  end
end
sstr =
Dir["*.rb"].each.each_with_index.map do |m,i|
  m
end
Font.default = Font.new(30)
cc = My_cycle.new sstr.size

mouse = Sprite.new
mouse.collision = [0,0]


# --------------------------------------------------------------------------------------
Window.loop do | o , node_self |
  exit if Input.keyPush? K_F9
  Sprite.update [ s , a , 3]
  Sprite.draw [ s , a]
#  Sprite.clean [ s , a]
  Sprite.check [s , a]
#  s.draw

  mouse.x, mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

  if Input.keyPush? K_ESCAPE
    cc.rewind
  end
  if Input.keyPush? K_UP
    cc.next
#    a.vanish
  end
  if Input.keyPush? K_DOWN
#    cc.rewind
    cc.prev
#    s.vanish
  end
  sstr.each_with_index do |m,i|
    font_hash  = {}
    yh = 20

    if sstr[cc.peek].hash == sstr[i].hash
      font_hash = { :color => [100,200,200] }
      Window.draw_font(50 ,400 , cc.peek.to_s << sstr[cc.peek] , Font.default , font_hash )
      Window.draw_font(50 ,10 + (yh*i) , ">>" , Font.default , font_hash )
      Window.draw_font(100,10 + (yh*i) , m , Font.default , font_hash )
    else
      Window.draw_font(100,10 + (yh*i) , m , Font.default , font_hash )
    end
  end

end
