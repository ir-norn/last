# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__


# ------------------------------------------------------------------
#
#           game stop
#
#
#
#
#
#
# ------------------------------------------------------------------

class Yuyukosama

  def fade_out hs = Hash.new
    o = self
    d = Image.new(Window.width,Window.height,[0,0,0])
    hs = ({ x: 0 , y: 0 , d: d , z: 10 ,
        sym: sym ,
        alpha:  ({ type: :default, start: 0 , limit: 255 , add: 4  }) ,
      }.merge hs )
    o.miko hs do | o |
      case o.c
      when 255 / 4
        o.delete
      end
      yield o if iterator?
    end # temp
  end

  def fade_in hs = Hash.new
    o = self
    d = Image.new(Window.width,Window.height,[0,0,0])
    hs = ({ x: 0 , y: 0 , d: d , z: 10 ,
        sym: sym ,
        alpha:  ({ type: :default, start: 255 , limit: 0 , add: -4  }) ,
      }.merge hs )
    o.miko hs do | o |
      case o.c
      when 255 / 4
        o.delete
      end
      yield o if iterator?
    end # temp
  end
end




#
# tmp dir つかうべき
#
# Dir.tmpdir
#

class Field_old
  
def self.game_stop o


    user_key = Vk_Input.new("profile0")
 if user_key.vkeyPush? :vk6
 
#      if Input.vkeyPush? :vk1
    back_file = Lumia.screenshot "tmp_screen"
    back = Image.load( back_file )
    File.unlink back_file
    
    font = Font.new 40

    o.Loop(:stop_nyan) do |o|
      o.fade_in({
       z: 10
      })
#          Window.drawEx 0 , 0 , back , {  :alpha=>145 , z: 10 } 
      
      o.miko({ d: back , 
        alpha:({ type: :default , start: 255 , limit: 145 , add: -1 }) ,
      }) do |o|
      end
      
#          o.miko({ d: Image.load("img/m/yuyu1.bmp")
#          }) do |o|
#          end
      
      0.times do | i |
        o.miko({
          x: 400 , y: 50 + i * 100 , d: Image.new( 100 , 100 , [120,220,150] ) ,
          alpha:  ({ type: :loop_rev, start: 20 , limit: 255  , add: 3    }) ,
          rot:    ({ type: :loop_rev, start: 0 , limit: 255  , add: 0.8    }) ,
        })
      end
      o.miko({
      }) do |o|
        o.n ||= 0
        o.n += 1 if o.n < 200
        next if o.n != 100
#            if o.n == 100
        remi = Yukarin.key_focus_create
        sstr = [ "yes" , "no" ]
        font2 = Font.new 30
        phase = :if_saikai
        
        remi2 = Yukarin.key_focus_create
        sstr2 = [ "yes" , "no" ]
        focus = 0
        focus2 = 1
        
        o.miko({
          alpha:  ({ type: :default,  start: 20 , limit: 255  , add: 3   }) ,
        }) do | o |
          case phase
            when :if_saikai
            Window.drawFont 100 , 100 , "restart?" , font , { color: [150,150,200 ] , alpha: 170 , }
            focus = remi.call  sstr.size , :vk_up  ,  :vk_down
            space = 50
            size  = 1
            sstr.each_with_index do | m , i |
              if i == focus
                Window.drawFont 100 , 250+(i-size)*space , m , font2 , { color: [150,150,200 ] , alpha: 170 , }
                Window.drawFont 50  , 250+(i-size)*space , ">>"   , font2 , { color: [150,150,200 ] , alpha: 170 , }
              else
                Window.drawFont 100 , 250+(i-size)*space , m , font2 , { color: [150,150,200 ] , alpha: 170 , }
              end
            end
            if Input.vkeyPush?(:vk0) || user_key.vkeyPush?(:vk0)
              if focus == 0
                o.up.up.up.delete
              end
              if focus == 1
                phase = :if_exit
              end
            end
            if Input.vkeyPush?(:vk1) || user_key.vkeyPush?(:vk1)
#                o.miko({ d: back , 
#                  alpha:({ type: :default , start: 255 , limit: 145 , add: -1 }) ,
#                }) do |o|
#                end

# もどる
# search うまくうごいてない
            o.up_search(/title/).delete

            end

            when :if_exit

            Window.drawFont 100 , 100 , "exit?" , font , { color: [150,150,200 ] , alpha: 170 , }
#              p focus2
            focus2 = remi2.call  sstr2.size , :vk_up  ,  :vk_down , focus2
#               p focus2
#                exit
            space = 50
            size  = 1

            sstr2.each_with_index do | m , i |
              if i == focus2
                Window.drawFont 100 , 250+(i-size)*space , m , font2 , { color: [150,150,200 ] , alpha: 170 , }
                Window.drawFont 50  , 250+(i-size)*space , ">>"   , font2 , { color: [150,150,200 ] , alpha: 170 , }
              else
                Window.drawFont 100 , 250+(i-size)*space , m , font2 , { color: [150,150,200 ] , alpha: 170 , }
              end
            end

            if Input.vkeyPush?(:vk0) || user_key.vkeyPush?(:vk0)
              if focus2 == 0
                o.search_up(/game_main/).delete
              end
              if focus2 == 1
                phase  = :if_saikai
              end
            end
            if Input.vkeyPush?(:vk1) || user_key.vkeyPush?(:vk1)
              phase  = :if_saikai
#                o.miko({ d: back , 
#                  alpha:({ type: :default , start: 255 , limit: 145 , add: -1 }) ,
#                }) do |o|
#                end
#                o.up.up.up.delete
            end
           end # case 
        end # o
#            end
      end # o
      
      o.Code do

      end # code
    end # loop
  end # if

    
end # d
end #cc











