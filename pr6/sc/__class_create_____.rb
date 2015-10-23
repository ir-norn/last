# -*- encoding: UTF-8 -*-
require "kconv"
	
ARGV.each do |m|


str = <<-TTT
\# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

\# ---------------------------------------- #{m} ----------------------------------------
module Tewi
  class #{m.capitalize}
    def initialize o
      init o
      init2 o
    end \# initialize
    def init2 o
      
      o.miko({ sym: :#{m.downcase} }) do | o |
        
      end \# o
    end \# init2

    def init o
        
\#      o.fade_in
      o.miko({ sym: :#{m.downcase} }) do | o |
        Window.drawFont(50,  10, "--#{m}--"   , Yuyuko.font)
        
      end \# o
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

