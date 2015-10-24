# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Game_over ----------------------------------------
module Tewi
  class Game_over
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :game_over }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :game_over }) do | o |
        Window.drawFont(50,  10, "--Game_over--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Game_over

end # m
