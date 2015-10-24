# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Title ----------------------------------------
module Tewi
  class Title
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :title ,  d: Yuyuko.dd , }) do | o |
        
      end # o
    end # init2

    def init o
      
      back = Image.load("img/title.png")
      font = Font.new(70 , "Comic Sans MS")

      func = ->o,x,y{
        img   = Image.new(60,60,[120,220,210])
        alpha = Yukarin.count_limit_create 10 , 180  , 0.6
        rot   = Yukarin.count_limit_create 900 , 0  , -1
        o.miko do | o |
          Window.drawEx(x,y,img, angle: rot.call , alpha: alpha.call , blend: :add )
        end
      }
      o.fade_in({ z: 50 })

      o.miko({ sym: :title ,
      }) do | o |
        case o.c
        when 45
            func.call o , 10 , 10
        when 90
            func.call o , 550 , 10
        when 135
            func.call o , 10 , 400
        when 260
          img   = Image.load("img/logo.png")
          alpha = Yukarin.count_limit_create 50 , 220 , 1
          rot   = Yukarin.count_limit_create 0  , 900  , 0.4
          o.miko do | o |
            Window.drawEx(500,360,img, angle: rot.call , alpha: alpha.call )
          end
        when 535
          $Scarlet.frandoll << :ok
        end

#       p o.c
        Window.drawFont(150,  40, " N o w l o a d i n g ..."   , font , color: [100,100,240] , alpha: 150 )
        Window.drawEx(100,50,back, alpha: 150 )
        
        o.Init do
          10.times do |i|
          im = Hatate::Imprint.new

          o.miko({
            sym: :effect ,
            x: 0 + i*70 , y: 0 - i*50 , d: Image.new(40,40,[100,100 + i*10 ,100]) ,
            angle: 90 , speed: 3 ,
            alpha:  ({ type: :default, start: 70 , limit: 255 , add: 1  }) ,
            rot:    ({ type: :default, start: 0  , limit: 900 , add: 1  }) ,
          }) do | o |


            o.Init do
              
              o.delete_lazy 400
            end # i
            im.draw o.x , o.y , o.d
#            o.y += 3
          end # o
          
          end # times
          
        end 

      end # o
    end # init
    
  end # Title

end # m
