# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Exit ----------------------------------------
module Tewi
  class Exit
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :exit }) do | o |
        
      end # o
    end # init2

    def init o
        
      fhs = ({ color: [160,190,226,], alpha: 240 })
      o.fade_in
      o.miko({ sym: :exit }) do | o |
        Window.drawFont(150,  260 ,  "--Exit . . .  . ."  , Yuyuko.font2, fhs )
        case o.c
          when 30
            exit
        end
        
      end # o
    end # init
    
  end # Exit

end # m













