# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Menu_pattern_0 ----------------------------------------
module Nyan
  class Menu_pattern_0
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

        sstr = @sstr || [ *"a".."z" ].zip(["__"].cycle).map(&:join)
        remi = @remi || Yukarin.key_focus_create2
        o.miko do
          focus = remi.call  sstr.size , K_UP  , K_DOWN , focus , 6 , 4
          space = 20
          padding_top = 50
          str_p = ">>"
          font = @font || Yuyuko.font3_20
          xx = 50
          fx = 4
          hss        = { :z => -2 ,  :alpha => 230 , :color => [220,200,220] }  
          hss_select = { :z => -2 ,  :alpha => 230 , :color => [100,100,200] }   
          # main
          sstr.rotate(focus).each_with_index do| m , i |
            yy = padding_top+i*space
            if  i  == 0
              Window.drawFont( xx                        , yy + (fx*space) , m.to_s  ,font , hss_select )
              Window.drawFont( xx-(font.get_width(str_p)), yy + (fx*space) , str_p   ,font , hss_select )
            else
              Window.drawFont( xx , yy + (fx*space) ,  m.to_s , font , hss )
            end
          end
          # ue
          sstr.rotate(focus)[-fx..-1].each_with_index do| m , i |
            yy = padding_top+i*space
            Window.drawFont( xx , yy + (0*space) , m.to_s ,font  , hss  )
          end
          #sita
          if focus > (sstr.size-fx)
            sstr[0..fx].each_with_index do| m , i |
              i  += ( sstr.size - focus )
              yy  = padding_top+i*space
              Window.drawFont( xx , yy + (fx*space) , m.to_s ,font , hss  )
            end
          end
          
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

module Tewi
  class Menu_pattern_0
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      a = Nyan::Menu_pattern_0.new
      
#      def a.ok o
#        p 2
#      end
#      a.define_singleton_method :ok do |o|
#        p 56
#      end

      a.create o
      
      o.miko({ sym: :menu_pattern_0 }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :menu_pattern_0 }) do | o |
        Window.drawFont(50,  10, "--Menu_pattern_0--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Menu_pattern_0

end # m
