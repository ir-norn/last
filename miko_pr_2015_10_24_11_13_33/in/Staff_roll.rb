# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Staff_roll ----------------------------------------
module Tewi
  class Staff_roll
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :staff_roll }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :staff_roll }) do | o |
#        Window.drawFont(50,  10, "--Staff_roll--"   , Yuyuko.font)
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
        Window.drawFont(50,  100, " back gournd "   , Yuyuko.font2_90 , alpha:100 )
        Window.drawFont(50,  180, " 幽 "   , Yuyuko.font2_90 , alpha:100 )
      end
    end

#
#
#
    def ending_main_create o
      $Scarlet.sound[:bgm_all_stop].call
      $Scarlet.sound[:staff_roll].play

      back  = Image.load "img/dote/ed_r.jpg"
      o.miko do |o|
        Window.draw 0, 0, back
        ccc = o.c

        Window.drawFont( 40,40, ccc.to_s   , Yuyuko.font2_40 ) if $de

        case ccc
        when 10
          o.miko({ x:50 , y:400 }) do |o|            
            Window.drawFont(00,  0, "staff rolll"   , Yuyuko.font2_20 )
#            o.y -= 1
             [
               "--SpecialThanks-- " ,
               "th project  zun",
               "language ruby  matz" ,
               "gui lib dxruby  mirchi" ,
               "compiler ocra  larsch" ,
               "-- creater --" ,
               "-- ゆ？ --" ,
             ].zip([[""]*2].cycle).flatten.each_with_index do | m , i|
                Window.drawFont( o.x , o.y + i * 50 , m  , Yuyuko.font2_40 )
             end
             if o.y > -700
               o.y -= 1               
             end
          end
        when 700 + 400
          o.miko({ x:400 , y:400 }) do |o|            
            ccc = o.c
            alpha = ccc
            alpha = 255 if alpha > 255
            fs = ({ color: [200,200,240] ,  alpha: alpha })
            Window.drawFont( o.x ,  o.y , " next ... dream ...... "   , Yuyuko.font2_40 , fs )
            case ccc
            when 254 
            end
            if 255 < ccc
              if Input.vkeyDown? :vk0
                o.search_up(/title/).delete
              end
            end


          end

        end # case
      end # o
    end # df


    
  end # Staff_roll

end # m
