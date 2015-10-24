# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__
#
# 2015-10-24 06:15:02 +0900
# ---------------------------------------- field ----------------------------------------
module AnneRose
  class Field
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o

    end # init2

    def init o
      o.Task :nyaxxxx do |o|  o.Code do
           Window.drawFont(50,  10, "--field--"   , $Scarlet.Font)
		  end	end # o
    end # init

  end # field
end # m
