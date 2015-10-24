# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

module Nyan
  class Menu_pattern_5
    def initialize hs = Hash.new

    end

    def menu_init o , menu_task
        # a = 40.step(40*12,40).to_a*3
        # b = [100]*12 + [200]*12 + [300]*12
        # c = ([*"a".."z"] + [*"A".."Z"] ).take(36)
        # p [a,b,c].transpose.flatten
        [
        40 , 100, "a", 80 , 100, "b", 120, 100, "c", 160, 100, "d",
        200, 100, "e", 240, 100, "f", 280, 100, "g", 320, 100, "h",
        360, 100, "i", 400, 100, "j", 440, 100, "k", 480, 100, "l",
        40 , 200, "m", 80 , 200, "n", 120, 200, "o", 160, 200, "p",
        200, 200, "q", 240, 200, "r", 280, 200, "s", 320, 200, "t",
        360, 200, "u", 400, 200, "v", 440, 200, "w", 480, 200, "x",
        40 , 300, "y", 80 , 300, "z", 120, 300, "A", 160, 300, "B",
        200, 300, "C", 240, 300, "D", 280, 300, "E", 320, 300, "F",
        360, 300, "G", 400, 300, "H", 440, 300, "I", 480, 300, "J"]
        .each_slice(3) do | xx , yy , str  |
          next if ("A".."Z") === str
          font  = Yuyuko.font2_50
          color = [200,220,240]
          d     = Image.new( font.get_width(str) , font.size , [0,250,240,250])
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
            when :ok
               p o.sym
            when :ok_n
            when :ce
            when :ce_n
            when nil
            end
            if o.active
#              tx += 0.8 if tx < 70
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
      
      ww = 40
      hh = 100
      koishi = ->{
          koishi.instance_eval{ [ x , y , w , h ] } }
      koishi.var_add :x , :y , :w , :h , :d
      koishi.x = ww
      koishi.y = 100
      koishi.w = 20
      koishi.h = 20
      koishi.d = Image.new( koishi.w , koishi.h , [150,210,250])

      menu_task = []
      remi =  Yukarin.kcc
      o.miko({ :sym => :hakurei }) do | o |
        o.Init do
          menu_init o , menu_task
        end # init
        next if menu_task.empty?
#        focus = remi.call  menu_task.size , K_UP  , K_DOWN , focus , 6 , 4
        menu_task.each do |m|
          m.active = Lumia.blockhit( *koishi.call , m.x , m.y , m.d.width , m.d.height )

          break_f = false
          [ 
           K_RIGHT , m.x - ww , m.y , ww  , 0 ,
           K_LEFT  , m.x + ww , m.y , -ww , 0 ,
           K_UP    , m.x , m.y + hh , 0 , -hh ,
           K_DOWN  , m.x , m.y - hh , 0 ,  hh ,
          ].each_slice(5) do | key , xx , yy , tw , th |
            if Input.vkeyPush? key
              if Lumia.blockhit( *koishi.call , xx , yy , m.d.width , m.d.height )
                koishi.x += tw
                koishi.y += th
                break_f = true 
                break
              end
            end
          end
          break if break_f
        
        end # e

#        Window.drawEx koishi.x , koishi.y , koishi.d ,  { :z => 10 }  

        
        if Input.keyPush? K_Z
          p :ok
#          menu_task.select{|m|m.active}.first.msg << :ok
          menu_task.map{|m|
            if m.active
              m.msg << :ok
            else
              m.msg << :ok_n
            end
          }
        end
  
        if Input.keyPush? K_X
          p :ce
#          p menu_task.select{|m|m.active}.first.sym
          menu_task.map{|m|
            if m.active
              m.msg << :ce
            else
              m.msg << :ce_n
            end
          }
        end
      
      end # m
    end # df cc


  end
end
# ---------------------------------------- Menu_pattern_5 ----------------------------------------
module Tewi
  class Menu_pattern_5
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      a = Nyan::Menu_pattern_5.new
      
      a.cc o
      
      o.miko({ sym: :menu_pattern_5 }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :menu_pattern_5 }) do | o |
        Window.drawFont(50,  10, "--Menu_pattern_5--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Menu_pattern_5

end # m



__END__


  
=begin
          if Input.keyPush? K_RIGHT
            if Lumia.blockhit( *koishi.call , m.x - ww , m.y , m.d.width , m.d.height )
              koishi.x += ww
              break
            end
          end
  
          if Input.keyPush? K_LEFT
            if Lumia.blockhit( *koishi.call , m.x + ww , m.y , m.d.width , m.d.height )
              koishi.x -= ww
              break
            end
          end       
  
          if Input.keyPush? K_UP
            if Lumia.blockhit( *koishi.call , m.x , m.y + hh , m.d.width , m.d.height )
              koishi.y -= hh
              break
            end
          end
          if Input.keyPush? K_DOWN
            if Lumia.blockhit( *koishi.call , m.x , m.y - hh , m.d.width , m.d.height )
              koishi.y += hh
              break
            end
          end
=end