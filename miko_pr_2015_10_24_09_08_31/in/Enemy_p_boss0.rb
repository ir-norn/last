# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------------
#  20:01 2012/07/25
#  
#  boss 0
#
#
#
#
#
#
#
# ------------------------------------------




module Patchouli_Enemy
  def boss0_top o , hs = Hash.new

    d = hs[:d] || Yuyuko.dd
    x = hs[:x] || 0
    y = hs[:y] || 0

  
#  $Scarlet.message[ :field ] << :boss_deth
#  return


    miko.miko({ sym: :effect , x: x , y: y,  d: d ,
    }) do |o , x , y|
      boss_hs = ({ d: Image.load("img/dote/reimu0.png") })
      o.Init do
        boss0_main o , boss_hs
      end
      case $Scarlet.message[ :boss0_top ].shift
        when :pert2
           boss1_main o , boss_hs
      end
    end
  end

  def boss1_main o , hs = Hash.new
    # Lumia.get_client_xy_center(o)
    # user
# init
    d = hs[:d] || Image.new(50, 50, [200,200,150])
    x = hs[:x] || 100
    y = hs[:y] || 100
    miko.miko({ sym: :enemy , x: x , y: y,  d: d ,
    }) do |o , x , y|
      o.Init do
        o.life = 10
        o.destruct = ->{
          $Scarlet.message[ :field ] << :boss_deth
        }
      end
      o.x += 0.1
      Window.drawFont2 40 , 40 , "l"*o.life
      if false
        next 
      end
# msg
      case $Scarlet.message[ :boss ].shift
        when :msg
           p :test
      end
# move
      ccc = o.c
      case ccc
      when 1
      end
# shot
      case ccc
      when 1
#        Enemy_shot::default o
      end
# rect
#      rect_delete o 
    end
  end



  def boss0_main o , hs = Hash.new
    # Lumia.get_client_xy_center(o)
    # user
# init
    d = hs[:d] || Image.new(50, 50, [200,150,150])
    x = hs[:x] || 100
    y = hs[:y] || 100
    ranxx = Lumia.get_client_xy_center(d)[0]
    ranx = Yakumo_ran.loop_rev_create({
      start: 60 ,
      start_init: 100 ,
      limit: 400 ,
      add: 1 ,
      #loopwait: 20 ,
      loopwait_ex_wait: 50,
      loopwait_ex: [60 , ranxx , 400] ,
#      add_plus: 1 ,
      })

    rany = Yakumo_ran.loop_rev_create({
      start: 60 ,
      start_init: 100 ,
      limit: 130 ,
      add: 1 ,
      #loopwait: 20 ,
      loopwait_ex_wait: 500,
      loopwait_ex: [60 , 70 , 100 , 110 , 130 , ] ,
      #add_plus: 1 ,
      })
      
    
    miko.miko({ sym: :enemy , x: x , y: y,  d: d ,
    }) do |o , x , y|
      o.Init do
        o.life = 10
        o.destruct = ->{
          $Scarlet.message[ :boss0_top ] << :pert2
        }
        # boss登場時に、何かエフェクトだしてもいいかも
      end
      Window.drawFont2 40 , 40 , "l"*o.life
      if false
        next 
      end
      o.x = ranx.call
      o.y = rany.call
# msg
      case $Scarlet.message[ :boss ].shift
        when :msg
           p :test
      end
# move
      ccc = o.c
      case ccc
      when 1
      end
# shot
      case ccc
      when 1
#        Enemy_shot::default o
      end
        o.st.xx ||= Yukarin.count_loop_rev_create 100 , 300 , 1
        o.x  = o.st.xx.call
        o.st.n ||= 0
        o.st.n = ( o.st.n + 1 ) % 120
        if (0..40) === o.st.n  and  (o.st.n%8 == 0)
          Enemy_shot.boss_shot1 o
        end

# rect
#      rect_delete o 
    end
  end

  def boss0_main__ o , hs = Hash.new
        p 4
  end
  def boss0_dummy o , hs = Hash.new
    mv = Yuka.h_move    
    d = hs[:d] || Image.load("img/dote/reimu0.png") # Image.new(50, 50, [200,150,150])
    x = hs[:x] || 100
    y = hs[:y] || -100
    
#    Enemy::boss0_top o
#    return 
    

 #   p get_client_center d
    miko.miko({ sym: :effect , x: x , y: y,  d: d ,
    }) do |o , x , y|
#      Window.drawFont2 20,300,"#{user.x}"
#      init move
      x , y = Lumia.get_client_xy_center(o)

      if mv.call  o , x , y , 4
         $Scarlet.message[:field] << :boss_haiti_ok
      end
      case $Scarlet.message[:boss].shift
        when :kaiwa_end
        o.delete
        Enemy::boss0_top o
#        Enemy::boss0_main o
        #+ boss create 
      end
#      if homing_move o , 100 , 200
#        p 3
#      end
      if false
        next 
      end
#      move
      ccc = o.c
      case ccc
      when 1
      end
# shot
      case ccc
      when 1
      end
# msg
#      rect_delete o 

    end
  end # d
  def boss0 o
#      def default o
    oo = o
    tmp = o.class.new
    imprint = Imprint.new
    tmp.d = Image.load("./img/boss/0.png")
#        x , y = Lumia.get_xy_center( o , tmp )
    x = 200
    y = -50
    phase =  0
    o.miko({ sym: :enemy ,
      x: x , y:y,
      d: tmp.d ,
    }) do |o|
      imprint.draw o.x , o.y , o.d
      o.Init do
      end
      case phase
      when 0
        if o.y < 80
          o.y += 1
        else
          p 9
          phase = :msg_wait
          # 指定座標まできたら会話開始
          $Scarlet.aya << :kaiwa_start
        end
      when :msg_wait
        case $Scarlet.msg.shift
        when :kaiwa_end          
        # 会話終了メッセージを受け取ったら、ボス開始
          phase = :start
        end
      when :debug
        o.x = 200
        o.y = 80
        phase = :start 
      when :tokuten_baramaki
        phase = 45454
        tokuten_baramaki o
      when :start
        o.st.xx ||= Yukarin.count_loop_rev_create 100 , 300 , 1
        o.x  = o.st.xx.call
        o.st.n ||= 0
        o.st.n = ( o.st.n + 1 ) % 120
        if (0..40) === o.st.n  and  (o.st.n%8 == 0)
          Enemy_shot.boss_shot1 o
        end
      end
#          rect_delete o  # boss
    end
  end # d      

  
  def tokuten_baramaki o

    oo_list = [] 
    90.times do |i|
      miko.miko({ sym: :enemy_shot ,
        x: rand(600) , y: rand(480),
        d: Image.new(20,20,[200,100,120,220]) ,
      }) do |o|
        o.Init do
           oo_list << o
        end
        case o.c
        when 0..50
          o.y-= 0.1
        when 60
          dd = Image.new(20,20,[200,100,220,220])

          speed = Yukarin.count_limit_create 0.1 , 5   , 0.02
          miko.miko({ sym: :item_tokuten ,
            x: o.x , y: o.y ,
            alpha: ({ type: :default, start: 255 , limit: 55 , add: -1  }) ,
            rot:   ({ type: :default, start: 0 , limit: 555 , add: 1  }) ,
            d: Image.new(20,20,[200,100,120,220]) ,
          }) do |o , angle , x , y|
            o.Init do
              oo_list.each do|oo|
               oo.delete
              end
            end
            x , y = Lumia.get_xy_center( user ,  o )
            
            angle = Lumia.homing_angle o.x , o.y , x , y
            o.x , o.y = Lumia.move o.x , o.y , speed.call , angle     

          end
          
        end

        rect_delete o 
      end
    end # times
  end # def
end #m


module Patchouli_Enemy_shot

  def boss_shot1 o

        
        36.step(360 , 36).each_with_index do | ang , i |
          next if (190..350) === ang
          tmp = o.class.new
          tmp.d = Image.new(10,40,[150,170,180,240])
          x , y = Lumia.get_xy_center( o , tmp )

          miko.miko({ sym: :enemy_shot ,
            x: x , y:y,
            speed: 2 , angle: ang ,
            rot: ({ type: :default, start: ang , limit: ang , add: 1  }) ,
            d: tmp.d ,
          }) do |o|
            o.Init do
            end

            rect_delete o 
          end
        end # times

#              Enemy_shot::boss_0_shot o

  end
  
  
  def boss_0_shot o
    
    2.times do |i|
      tmp = o.class.new
      tmp.d = Image.new(10,40,[150,170,180,240])
      x , y = Lumia.get_xy_center( o , tmp )
      ang = [ 45 , 135 ][i]
      o.miko({ sym: :enemy_shot ,
        x: x , y:y,
        speed: 2 , angle: ang ,
        d: tmp.d ,
      }) do |o|
        o.Init do
        end
        
        rect_delete o 
      end
    end # times
  end # d

  
  
end


module Patchouli_Knowledge

  module Enemy
    
    class << self

      def rect_delete o
        unless Lumia.blockhit o.x , o.y , o.d.width , o.d.height ,
           -50 , -50 , Window.width-100 , Window.height+50
           o.delete
        end
      end # d 
      
    end # c self
  end # em
end # m




module Patchouli_Knowledge

  module Enemy_shot
    class << self


    end # c self
  end # em
end # m


