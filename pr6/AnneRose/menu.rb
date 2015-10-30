#coding:utf-8
#
require"dxruby"

##
module Create_method_print
  def self.extended o
    name = :print
    o.extend Module.new { attr_accessor name }
#    Font.default
#    Font.default=
    font = Font.new(50)
    o.define_singleton_method name do |x , y , str|
      Window.drawFont x, y, str, font
    end
  end
end



ARGV.replace [ *ARGV , 2 ]
ARGV.replace [ *ARGV , 4 ]
p ARGV
ARGV.clear


Window.loop do |o|


end
