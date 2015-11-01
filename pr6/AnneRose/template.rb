#coding:utf-8
#require "__dev/req" if $0 ==__FILE__
require"dxruby"
# ARGV.replace [ *ARGV , 1 , 2 ]
# ARGV.clear
# if $0 == __FILE__
# end


Window.loop do |o|
  exit if Input.keyPush? K_F9
  Window.draw_font(50,100,"template",Font.default)

end
