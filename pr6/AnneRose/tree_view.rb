#coding:utf-8
require "__dev/req" if $0 ==__FILE__
require"dxruby"

@font = Font.new(14)
@font2_hash = { :color => [100,200,200] }
a = nil
Window.loop do |o|
  @node_self = o
  if @node_self.DEBUG_CODE.STATIC_LOGIC
    def f o , n = 1
      o.task.map do | o |
        [ n , o ] + f(o , n + 1)
      end
    end
    a = f(o.TOP_NODE).flatten
    a = a.each_slice(2).reject do|n,o|
      o.sym =~ /^__/ end.flatten
  end

  a.each_slice(2).with_index 1 do |( n , v ), i|
    xw = 15
    yh = 15
    font_hash = o.sym == v.sym ? @font2_hash : nil
    w = @font.get_width(v.sym.to_s)
    Window.draw_font( xw  , yh * i , v.sym.to_s , @font , font_hash )
  end

end
