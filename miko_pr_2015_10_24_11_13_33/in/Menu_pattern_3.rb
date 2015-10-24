# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__


module Nyan
  class Menu_pattern_3
    def initialize hs = Hash.new
      @sstr   = hs[:sstr ]
      @remi   = hs[:remi ]
      @font   = hs[:font ]
      @str_p  = hs[:str_p ]
      @hss1   = hs[:hss1 ]
      @hss2   = hs[:hss2 ]
      @space  = hs[:space ]
      @x              = hs[:x ]
      @y              = hs[:y ]
      @fx             = hs[:fx ]
      @padding_top    = hs[:padding_top ]
      @padding_bottom = hs[:padding_bottom ]     

  

    end
    
    def create o
  
        sstr = [ *"a".."z" ].take(10).zip(["__"].cycle).map(&:join)
        remi = Yukarin.key_focus_create2
        o.miko do
          focus = remi.call  sstr.size , K_LEFT , K_RIGHT , focus , 6 , 4
          space = 20
          str_p = ">>"
          font  = Yuyuko.font3_20
          xx    = 50
          yy    = 120
          fx    = 4
          hss        = { :z => -2 ,  :alpha => 230 , :color => [220,200,220] }  
          hss_select = { :z => -2 ,  :alpha => 230 , :color => [100,100,200] }   
          # main
    	     font_color = Yuyuko.font_select_no_color
    	     sstr.each_with_index do| m , i |
      	     xy   = [ xx      ,  yy + i * space ]
      	     xy_p = [ xx - 20 ,  yy + i * space ]
      	     xy.reverse!
      	     xy_p.reverse!
    	       if i == focus
    	            Window.drawFont( *xy_p  , ">>"    , font , hss_select )
    	            Window.drawFont( *xy_p  , m.to_s  , font , hss_select )
    	       else Window.drawFont( *xy_p  , m.to_s  , font , hss        )
    	       end
    		  end # e
          ok o , focus
          
          ce o , focus
          
        end # miko
     
    end # df
    
    def ok o , focus
      if Input.keyPush? K_Z
        p :ok , focus
      end
    end
    
    def ce o , focus
      if Input.keyPush? K_X
        p :ce , focus
      end
      
    end

  end # c
end # m

# ---------------------------------------- Menu_pattern_3 ----------------------------------------
module Tewi
  class Menu_pattern_3
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      a = Nyan::Menu_pattern_3.new
      

      a.create o
      
      
      o.miko({ sym: :menu_pattern_3 }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :menu_pattern_3 }) do | o |
#        Window.drawFont(50,  10, "--Menu_pattern_3--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Menu_pattern_3

end # m
