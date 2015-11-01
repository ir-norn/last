#coding:utf-8
#require "__dev/req" if $0 ==__FILE__
require"dxruby"
if $0 == __FILE__
  ARGV.replace [ 1 , 2 ]
end

# x     = ARGV[0]
# y     = ARGV[1]
# ARGV.clear

Window.loop do |o|

  Window.draw_font(100,100," -- menu -- ",Font.default)

end
