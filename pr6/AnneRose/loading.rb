#coding:utf-8
require "__dev/req" if $0 ==__FILE__
require"dxruby"

count = 0
Window.loop do |o|
  Window.draw_font(200,200,"now loading...",Font.default)
  next if (count+=1)  < 100
#  p :load__
  o.up.delete
end
