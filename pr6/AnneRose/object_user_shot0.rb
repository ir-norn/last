#coding:utf-8
require "__dev/req" if $0 ==__FILE__
require"dxruby"
if $0 == __FILE__
#  ARGV.replace [ *ARGV , [100 , 300 , 3 , 0] ]
end

#p ARGV
x, y , speed = ARGV.shift

Window.loop do | o , node_self |
#  o.extend Module.new {attr_accessor:y}
  exit if Input.keyPush? K_F9
  y -=  speed
# p   o.sym
# p   o.up.sym
# p   o.up.up.sym
# p   o.up.up.up.sym
# exit
#  yy = 220
  # Window.draw_font(40,20+(yy+=20),"＊ #{o.sym}",Font.default)
  # Window.draw_font(40,20+(yy+=20),"＊ #{o.up.sym}",Font.default)
  # Window.draw_font(40,20+(yy+=20),"＊ #{o.up.up.sym}",Font.default)
  # Window.draw_font(40,20+(yy+=20),"＊ #{o.up.up.up.sym}",Font.default)
  # Window.draw_font(40,20+(yy+=20),"＊ #{o.up.up.up.up.sym}",Font.default)
#  p o.up.sym
#  p node_self.sym
#  exit
  Window.draw_font(x,y,"＊ #{o.up.up.task.size}",Font.default)
  if y < 0
#    p o.up.up.task.size
#   p o.up.sym
#   p node_self.sym
#   p o.up.hash == node_self.hash
#    o.up.delete
    node_self.delete
    # o.up.delete
#    p o.up.up.task.size
  end
end
