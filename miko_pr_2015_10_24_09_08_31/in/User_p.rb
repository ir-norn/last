# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__

module Patchouli_Knowledge
  module User
    class << self
    end
  end
  module User_shot
    class << self
    end
  end
end


#---------------------------------------------------------------------------
#
#
#
#
# --------------------------  user pattern ---------------------
#
#
#
#
#---------------------------------------------------------------------------


module Patchouli_User
  
      def default o
 
        img = Lumia.i_yuyukosama("img/user")
        img.var_add :point , :lo
        img.point = 0
        img.lo    = 
        img.dmap.size.map do |m|
          Yakumo_ran.lo({
            start: 0 ,
            limit: m ,
            loopwait_ex_wait: 20,
            loopwait_ex: [*0..m] ,
            add: 1 ,
          })
        end
        im = Hatate::Imprint.new

        x = 200
        y = 370
        miko.neko( :sym , x , y , Yuyuko.dd , { sym_uniq: :user }
          ) do |o|
          o.Init do
            Patchouli_Knowledge.user_set o
            
            #
            o.var_add :keyconfig 
            o.keyconfig = Vk_Input.new "profile0"
            o.var_add :zanki , :tokuten , :spell
            o.zanki = 3
            o.spell = 4
            o.tokuten = 1000
            o.var_add :img , :im
            o.img = img
            o.im  = im
            
          end
          o.Destruct do end
          
          draw  o

          move  o
          
          rumia o

        end
      end

      # 
      # キーが離されたらドット絵をはじめからにする
      #
      def draw o
        img  = o.img
        img.instance_eval do
          img.point = 
          if o.keyconfig.vkeyDown? :vk_right 
            2
          elsif o.keyconfig.vkeyDown? :vk_left  
            1
          else
            0
          end
          lo.each_with_index do | m , i |
            next if img.point == i
            m.c = 0
          end
          o.d = img[ point ][ lo[ point ].call  ]
          o.im.call o.x , o.y , o.d
        end # in ev
      end

      def rumia o
        key = o.keyconfig
        if key.vkeyDownWait? :vk0 , 5
          shot_A o
        end
        if key.vkeyDownWait? :vk1 , 9999
          spell o
        end
        if Input.keyDownWait? K_Q , 5
           User_shot::shot_nyan o
#           User_shot::pattern_0 o , o.d , 2 , 270
        end
      end

      def move o 
        user_key = o.keyconfig
        speed = 4
        angle = 0
        sstr =  [ :vk_down , :vk_left , :vk_up , :vk_right ]
        sstr.each_with_index do |m,i|if user_key.vkeyDown?(m);(angle=90*(i+1));( user_key.vkeyDown?(sstr[i-1])?(break(angle-=45)):nil);end;end
        if angle != 0
          o.x , o.y = Lumia.move o.x , o.y , speed , angle
          o.x = 20  if o.x < 20
          o.y = 20  if o.y < 20
          o.x = 480 - o.d.width  if o.x + o.d.width > 480
          o.y = 460 - o.d.height if o.y + o.d.height> 460
        end
      end # def m
#      def a
#        
#      end
  #
  #
  # とりあえず･･･的な、

    def shot_A o
#      User_shot::sdsd o , o.d , 1 , 50
#      Effect::sdsd o , o.d , 1 , 50

#      bb = Lumia.i_miko "img/dote"
#      miko.neko( :effect , 100 , 300 , ne , { dd: bb } )
#      User_shot::kotohi o , { dd: bb }
#      User_shot::kotohi o 
      User_shot::default_double o
    end
  
    def spell o
      User_shot::spell_default o
    end

end # pm












#---------------------------------------------------------------------------
#
#
#
#
# -------------------------- user shot pattern ---------------------
#
#
#
#
#---------------------------------------------------------------------------
module Patchouli_User_shot

  def default o
    oo = o
    tmp = o.class.new
    tmp.d = Image.new(10,40,[150,170,180,240])
    x , y = Lumia.get_xy_center( o , tmp )
    miko.miko({ sym: :user_shot ,
      x: x , y:y,
      d: tmp.d ,
    }) do |o|
      o.Init do
      end
      o.y -= 4
    end
  end # d
  
  def kotohime_kotohi o , hs = Hash.new , &block
    d = Image.new(10,40,[170,180,240])
#    miko.miko({ d: d }.merge(hs)) do | o |
    miko.miko({ }.merge(hs)) do | o |
      o.y -= 0.5
      o.x -= 0.5
    end
  end


  def kotohime_sdsd  o , hs = Hash.new , &block
    miko.miko hs , &block
  end # d


  def shot_nyan o
    x , y , d = Yuka.center o , Image.new(10,40,[150,170,180,240])
    miko.neko( :user_shot , x , y , d , ) do |o|
      o.y -= 4
    end
  end

  def spell_default o

     img = Image.load("img/dote/tokuten.png")
     enemy_shot.each do | a |
       speed = Yukarin.cc 0.1 , 7   , 0.08
       miko.neko( :item , a.x , a.y , img , {} ) do |o|
         case o.c
         when 0..50
           o.y -= 0.1
           next
         end
         Yuka.move o , speed.call , Yuka.h_user(o)
         rect_delete o
       end
     end
     enemy_shot.dmap.delete
    
  end # d
  
end # mp

#---------------------------------------------------------------------------
#
#
#
#
# -------------------------- user shot pattern ---------------------
#
#
#
#
#---------------------------------------------------------------------------

module Patchouli_User_shot
# ----------- user shot -----------------

#
#  default_double
#
#         ｜｜
#         ｜｜
#         ｜｜
#         ｜｜
#       　　 ■ 
#
#
#
      def default_double_ttmtmt o
        oo = o
        2.times do |i|
          hs = Hash.new
          tmp   = o.class.new
          tmp.d = Image.new(10,10,[170,180,240])
          x , y = Lumia.get_xy_center( oo , tmp )
          if i == 0
            x += o.d.width / 2
          else
            x -= o.d.width / 2
          end
          miko.miko({ sym: :user_shot ,
            x: x , y: y ,
            d: tmp.d ,
          }) do |o|
            o.y -= 4
            rect_delete o 
          end
        end # times 
      end # d  
      

      
      def default_double o
        oo = o
        2.times do |i|
          tmp   = o.class.new
          tmp.d = $Scarlet.dd.shot1
          x , y = Lumia.get_xy_center( oo , tmp )
          if i == 0
            x += o.d.width / 2
          else
            x -= o.d.width / 2
          end
          hs = Hash.new
          hs[:sym] = :user_shot
          hs[:x]   = x
          hs[:y]   = y
          hs[:d]   = tmp.d
          
          miko.miko hs do |o|
            o.y -= 4
            rect_delete o 
          end
        end # times 
      end # d    

#
#　default_triple
#
#　　　＼　　|　　／
#　　　　　＼|／
#   　　　 □
#
#
      def default_triple o
        tmp = o.class.new
        [225,270,315].each do | ang |
          hsang = ang + 90
          hs = ({ type: :default, start: hsang  , limit: hsang , add: 1 }) 
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )
          miko.miko({ sym: :user_shot ,
            x: x , y:y,
            d: tmp.d , angle: ang , speed: 4 ,
            rot: hs ,
          }) do |o|
            o.Init do
            end
            rect_delete o 
          end
        end # times
      end # d
#
#  laser
#
#         ｜｜
#         ｜｜
#         ｜｜□
#         ｜｜□
#       □□ ■ □□
#
#
#

      def laser o
        tmp = o.class.new
        tmp.d = Image.new(10,40,[150,170,180,240])
        x , y = Lumia.get_xy_center( o , tmp )

        miko.miko({ sym: :user_shot ,
          x: x , y: y ,
          d: tmp.d ,
        }) do |o|
          o.Init do | x , y , tmp |
            tmp = o.class.new
            tmp.d = Image.new(10,40,[160,220,240])
            x , y = Lumia.get_xy_center( o , tmp )
            o.miko({
              x: x , y: y , d: tmp.d ,
              alpha:  ({ type: :default, start: 1 , limit: 100 , add: 1  }) ,
            }) do |o|
            end
            next if rand(2) == 0
            tmp = o.class.new
            tmp.d = Image.new(70,150,[100,100,240])
            x , y = Lumia.get_xy_center( o , tmp )
            o.up.miko({
              x: x , y: y , d: tmp.d ,
              alpha:  ({ type: :default, start: 1 , limit: 100 , add: 0.4  }) ,
            }) do |o|
               o.Init do
#                 o.delete_lazy 400
               end              
               o.y -= 2
               rect_delete o 
            end

          end
          o.y -= 4
          rect_delete o 
        end
      end # d 


#
#  angle_90_180_270_360
#            |
#　　　　　　　　　　 |　
#         -- ■ --
#            | 
#            |
#
#
      def angle_90_180_270_360 o
#      def default o
        tmp = o.class.new
        [90,180,270,360].each_with_index do | m , __i |
          speed = 3
          angle = m
          rot   = angle - 90
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )
          miko.miko({ sym: :user_shot ,
            x: x , y:y,
            d: tmp.d , speed: speed ,
            angle: angle ,
            rot: ({ type: :default, start: rot  , limit: rot , add: 0 })   
          }) do |o|
            o.Init do
            end
            rect_delete o 
          end
        end # times        
      end
#
#  angle_180_360
#           
#　　　　　　　　　　 
#     ---- ■ ----
#           
#           
#
#
      def angle_180_360 o
        tmp = o.class.new
        [180,360].each_with_index do | m , __i |
          speed = 3
          angle = m
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )
          miko.miko({ sym: :user_shot ,
            x: x , y:y,
            d: tmp.d , speed: speed ,
            angle: angle ,
          }) do |o|
            o.Init do
            end
            rect_delete o 
          end
        end # times        
      end
#
#  angle_90_270
#           
#　　　　　　　　　|　 
#          ■ 
#          |  
#           
#
#
      def angle_90_270 o
        tmp = o.class.new
        [90,270].each_with_index do | m , __i |
          speed = 3
          angle = m
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )
          miko.miko({ sym: :user_shot ,
            x: x , y:y,
            d: tmp.d , speed: speed ,
            angle: angle ,
          }) do |o|
            o.Init do
            end
            rect_delete o 
          end
        end # times        
      end
#
#  cross_angle
#
#
#
#          Ｘ 
#         ／＼ 
#         ＼／  
#          Ｘ 
#　　　　　　　　／＼　 
#          ■ 
#           
#
      def cross_angle  o
        tmp = o.class.new
        2.times do |i , hs|
          if i == 0
            hs = ({ type: :default, start: 0  , limit: 900 , add: 2 }) 
          else
            hs = ({ type: :default, start: 900  , limit: 0 , add: -2 }) 
          end
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )
          miko.miko({ sym: :user_shot ,
            x: x , y:y,
            d: tmp.d ,
            rot: hs ,
          }) do |o|
            o.Init do
            end
            o.y -= 3.4
            rect_delete o 
          end
        end # times
      end # d
#
#
# １:single, 2:double, 3:triple, 4:quadruple, 5:quintuple,
# 6:sextuple, 7:septuple, 8:octuple, 9:nonuple, 10:decuple です。
#
#
# quadruple
#
#
#　　＼＼　/／
#    　□
#
      def default_quintuple  o
        tmp = o.class.new
        [210,250,290,330].each do | ang |
          hsang = ang + 90
          hs = ({ type: :default, start: hsang  , limit: hsang , add: 1 }) 
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )
          miko.miko({ sym: :user_shot ,
            x: x , y:y,
            d: tmp.d , angle: ang , speed: 4 ,
            rot: hs ,
          }) do |o|
            o.Init do
            end
            rect_delete o 
          end
        end # times
      end # d
#
# default_quintuple
#
#
#
#　　＼＼｜　/／
#     　□
#
#

      def default_quintuple  o
        tmp = o.class.new
        [210,240,270,300,330].each do | ang |
          hsang = ang + 90
          hs = ({ type: :default, start: hsang  , limit: hsang , add: 1 }) 
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )
          miko.miko({ sym: :user_shot ,
            x: x , y:y,
            d: tmp.d , angle: ang , speed: 4 ,
            rot: hs ,
          }) do |o|
            o.Init do
            end
            rect_delete o 
          end
        end # times
      end # d
#
# default_quintuple
#
#
#　　　|　　　　|
#　　　|　　　　|
#　　　|　　　　|
#　　　|　　　　|
#　　　　＼ ／
#     　□
#
#
      def default_waide o
        oo = o
        2.times do |i|
          tmp   = o.class.new
          tmp.d = $Scarlet.dd.shot1
          x , y = Lumia.get_xy_center( oo , tmp )
          if i == 0
            x += o.d.width / 2
          else
            x -= o.d.width / 2
          end
          hs = Hash.new
          hs[:sym] = :user_shot
          hs[:x]   = x
          hs[:y]   = y
          hs[:d]   = tmp.d
          
          miko.miko hs do |o|
            case o.c
            when 10..30
              o.x += [2,-2][i]
            end
            o.y -= 4
            rect_delete o 
          end
        end # times 
      end # d    
#
#　default_cross2
#
#　　　 ／ ＼
#　　　　＼ ／
#　　　 ／ ＼
#　　　　＼ ／
#　　　 ／ ＼
#　　　　＼ ／
#　　　 ／ ＼
#　　　　＼ ／
#     　□
#

      def default_cross2 o
        oo = o
        2.times do |i|
          tmp   = o.class.new
          tmp.d = $Scarlet.dd.shot1
          x , y = Lumia.get_xy_center( oo , tmp )
          if i == 0
            x += o.d.width / 2
          else
            x -= o.d.width / 2
          end
          hs = Hash.new
          hs[:sym] = :user_shot
          hs[:x]   = x
          hs[:y]   = y
          hs[:d]   = tmp.d
          start = x-30
          limit = x+30
          start , limit = limit , start if i == 0
          add   = [-3,3][i]
          ranx = Yakumo_ran.loop_rev_create({
            start: start ,
            start_init: x ,
            limit: limit ,
            add: add ,
            #loopwait: 20 ,
#            loopwait_ex_wait: 500,
#            loopwait_ex: [60 , 70 , 100 , 110 , 130 , ] ,
            #add_plus: 1 ,
            })

          miko.miko hs do |o|
            o.x = ranx.call
            o.y -= 4
            rect_delete o 
          end
        end # times 
      end # d    



end # m

