# -*- encoding: UTF-8 -*-
require "kconv"
require "Time"


ARGV.each do |m|


str = <<-TTT
\# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__
\#
\# #{Time.now}
\# ---------------------------------------- #{m} ----------------------------------------
module AnneRose
  class #{m.capitalize}
    def initialize o
      init o
      init2 o
    end \# initialize
    def init2 o

      o.Node_new sym: :#{m.downcase} do | o |

      end \# o
    end \# init2

    def init o
      o.Task :nyaxxxx do |o|  o.Code do
           Window.drawFont(50,  10, "--#{m}--"   , $Scarlet.Font)
		  end	end \# o
    end \# init

  end \# #{m}
end \# m
TTT

  puts str


  begin
    open( m + ".rb")
    p "file exist"
  rescue
    open( m + ".rb" , "w").print str.toutf8
    p "file create #{m}"
    puts %!require dir + "in/Menu"!
  end

end
