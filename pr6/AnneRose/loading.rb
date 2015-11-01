#coding:utf-8
require "__dev/req" if $0 ==__FILE__
require"dxruby"

count = 0
Window.loop do |o|
#  Window.draw_font(200,200,"now loading...",Font.default)
  next if (count-=1) > 0

  o.up.delete if $0 !=__FILE__
end
