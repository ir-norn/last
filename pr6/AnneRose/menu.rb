#coding:utf-8
#require "__dev/req" if $0 ==__FILE__
require"dxruby"
if $0 == __FILE__
  Dir.chdir File.dirname(File.expand_path(__FILE__))
  ARGV.replace [ 1 , 2 ]
end
# x     = ARGV[0]
# y     = ARGV[1]
# ARGV.clear

font = Font.new(14)
font2_hash = { :color => [100,200,200] }
font_hash  = {}
Window.loop do |o|
  exit if Input.keyPush? K_F9
#  Window.draw_font(100,100," -- menu -- ",Font.default)
  Dir["*.rb"].each.each_with_index do |m,i|
    # font_hash = o.sym == v.sym ? @font2_hash : nil
    # w = @font.get_width(v.sym.to_s)
    # Window.draw_font( xw  , yh * i , v.sym.to_s , @font , font_hash )
    yh = 15
    Window.draw_font(100,10 + (yh*i) , m , Font.default)
  end


end
