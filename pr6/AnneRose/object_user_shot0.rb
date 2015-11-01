#coding:utf-8
require "__dev/req" if $0 ==__FILE__
require"dxruby"
if $0 == __FILE__
  ARGV.replace [ 100 , 300 , 3 , 0 ]
end

x     = ARGV[0]
y     = ARGV[1]
speed = ARGV[2]
angle = ARGV[3]
ARGV.clear

Window.loop do |o|
  exit if Input.keyPush? K_F9
  Window.draw_font(50,130,"user_shot0",Font.default)

#  x += speed
  y -= speed
  Window.draw_font(x,y,"＊",Font.default)

  if y < 0
    o.delete
  end
end
