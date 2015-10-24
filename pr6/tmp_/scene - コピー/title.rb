# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- title ----------------------------------------
module AnneRose
  class Title
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o

#      o.Node_new sym: :title do | o |

#      end # o
    end # init2

    def init o
      o.Task :nyaxxxx do |o|  o.Code do
           Window.drawFont(50,  10, "--title--"   , $Scarlet.Font)
           if Input.keyPush? K_Z
             o.up.flandoll << :menu
           end
		  end	end # o
    end # init

  end # title
end # m
