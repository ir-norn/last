# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__


module Nyan
  class Menu_pattern_4
    def initialize hs = Hash.new

    end
    # -----------
    def menu_init o , menu_task

        # -------------------------------------------------------
        [
          40 ,  50 , "test" ,
          40 , 150 , "aaaa" ,
          40 , 250 , "bbbb" ,
        ].each_slice(3) do | xx , yy , str  |
          font  = Yuyuko.font2_60
          color = [200,220,240]
          d     = Image.new( font.get_width(str) , font.size , [250,240,250])
          d.drawFont( 0 , 0 , str , font , color )
          active_d  = Image.new( font.get_width(str) , font.size , [220,250,220])
          active_d.drawFont( 0 , 0 , str , font , color )
          hss = {  }
          tx  = xx
          ty  = yy
          o.miko({ :sym => :reimu , :x => xx , :y => yy ,
          :d => d ,
          }) do | o |
            o.Init {
              menu_task << o
              o.var_add :active , :msg
              o.msg = []
            }
            case o.msg.shift
            when nil
            end
            if o.active
              tx += 0.8 if tx < 70
              Window.drawEx tx , ty , active_d  , hss                
            else
              Window.drawEx o.x , o.y , o.d  , hss
              tx = o.x
              ty = o.y
            end
          end
        end
    end # df
    
    
    def cc o
      menu_task = []
      remi =  Yukarin.kcc
      o.miko({ :sym => :hakurei }) do | o |
        o.Init do
          menu_init o , menu_task
        end # init
        next if menu_task.empty?
        focus = remi.call  menu_task.size , K_UP  , K_DOWN , focus , 6 , 4
        menu_task.each {|m| m.active = false }
        menu_task[ focus ].active = true

        if Input.keyPush? K_Z
          p :ok , focus
        end
  
        if Input.keyPush? K_X
          p :ce , focus
        end
      
      end # m
    end # df cc

  end # c
end # m

# ---------------------------------------- Menu_pattern_4 ----------------------------------------
module Tewi
  class Menu_pattern_4
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o


      a = Nyan::Menu_pattern_4.new
      
      a.cc o
      

      o.miko({ sym: :menu_pattern_4 }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :menu_pattern_4 }) do | o |
        Window.drawFont(50,  10, "--Menu_pattern_4--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Menu_pattern_4

end # m



__END__



          return

          # -------------------------------------------------------
          instance_exec do
            xx    = 40
            yy    = 50
            str   = "test"
            font  = Yuyuko.font2_60
            color = [200,220,240]
            d     = Image.new( font.get_width(str) , font.size , [250,240,250])
            hss   = {  }
            d.drawFont( 0 , 0 , str , font , color )
            o.miko({ :sym => :reimu , :x => xx , :y => yy ,
            :d => d ,
            }) do | o |
              o.Init { menu_task << o }
              Window.drawEx o.x , o.y , o.d  , hss
            end
          end
          
          
          # -------------------------------------------------------
          instance_exec do
            xx    = 40
            yy    = 150
            str   = "aaaa"
            font  = Yuyuko.font2_60
            color = [200,220,240]
            d     = Image.new( font.get_width(str) , font.size , [250,240,250])
            hss   = {  }
            d.drawFont( 0 , 0 , str , font , color )
            o.miko({ :sym => :reimu , :x => xx , :y => yy ,
            :d => d ,
            }) do | o |
              o.Init { menu_task << o }
              Window.drawEx o.x , o.y , o.d  , hss
            end
          end
                    


          # -------------------------------------------------------
          instance_exec do
            xx    = 40
            yy    = 250
            str   = "bbbb"
            font  = Yuyuko.font2_60
            color = [200,220,240]
            d     = Image.new( font.get_width(str) , font.size , [250,240,250])
            hss   = {  }
            d.drawFont( 0 , 0 , str , font , color )
            o.miko({ :sym => :reimu , :x => xx , :y => yy ,
            :d => d ,
            }) do | o |
              o.Init { menu_task << o }
              Window.drawEx o.x , o.y , o.d  , hss
            end
          end
                    
            
      
      
      