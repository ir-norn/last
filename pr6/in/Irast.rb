# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Irast ----------------------------------------
module Tewi
  class Irast
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :irast }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :irast }) do | o |
        Window.drawFont(50,  10, "--Irast--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Irast

end # m




