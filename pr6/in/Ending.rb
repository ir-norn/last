# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Ending ----------------------------------------
module Tewi
  class Ending
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :ending }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :ending }) do | o |
        Window.drawFont(50,  10, "--Ending--"   , Yuyuko.font)
        o.Init do
          ending_main_create o
          background_create o
        end
        
      end # o
    end # init

#
#
#
    def background_create o
      img = nil
      o.miko do |o|
        Window.drawFont(50,  300, " back gournd "   , Yuyuko.font2_90 )
      end
    end

#
#
#
    def ending_main_create o
      $Scarlet.sound[:bgm_all_stop].call
      $Scarlet.sound[:ed].play
      
      back = Image.load "img/dote/haikei_33434.jpg"      
      o.miko do |o|
        Window.draw 0,0,back
        case o.c
        when 10
          o.miko do |o|
            Window.drawFont(50,  400, "text"   , Yuyuko.font2_40 )
#            o.y -= 1
          end          
        when 70
          o.miko do |o|
            Window.drawFont(50,  430, "text2222"   , Yuyuko.font2_40 )
          end          

        when 300
          $Scarlet.frandoll << :staff_roll
          
          
        end # case
      end # o
    end # df
    
  end # Ending

end # m



__END__

        [
         50 , 150 , "‚Æ‚­‚Ä‚ñ"  ,
         50 , 220 , "‚·‚Ä[‚½‚·A"  ,
         50 , 290 , "‚·‚Ä[‚½‚·B"  ,
        ].each_slice(3) { | x , y , str |
            o.miko({ sym: :effect , x: x , y: y , d: str , font: Yuyuko.font2_60 ,
            z: 12 ,
            alpha:   ({ type: :default, start: 120  , limit: 220 , add: 3  }) ,
            scalex:  ({ type: :default, start: 1 , limit: 1  , add: 0.01  }) ,
            scaley:  ({ type: :default, start: 0.7 , limit: 1  , add: 0.01  }) ,
            }) do |o|
              case o.c
              when 0..20
                 o.y += 1
              end # c
            end # o
          }