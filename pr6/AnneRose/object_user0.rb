#coding:utf-8
#require "__dev/req" if $0 ==__FILE__
require"dxruby"
if $0 == __FILE__
  ARGV.replace [ 200 , 200 ]
end

x = ARGV[0]
y = ARGV[1]
ARGV.clear

Window.loop do |o|
  exit if Input.keyPush? K_F9
  Window.draw_font(50,100,"user0",Font.default)

  x += Input.x * 4
  y += Input.y * 4
  Window.draw_font(x,y,"◇",Font.default)

  if Input.key_push? K_Z
    o.up.Flandoll << :object_user_shot0
    ARGV.replace [ x , y , 3 , 0 ]
  end

end
