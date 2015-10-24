# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__

module Patchouli_Knowledge
  module Enemy
    class << self
    end
  end
  module Enemy_shot
    class << self
    end
  end
end




#---------------------------------------------------------------------------
#
#
#
#
# --------------------------  enemy main ---------------------
#
#
#
#
#---------------------------------------------------------------------------


module Patchouli_Enemy

  def default o
    oo = o
    tmp = o.class.new 
    tmp.d = Image.new(50,50,[150,170,180,240])
#        x , y = Lumia.get_xy_center( o , tmp )
    x = 100
    y = 50
    o.miko({ sym: :enemy ,
      x: x , y:y,
      d: tmp.d ,
    }) do |o|
      o.Init do
      end
      if rand(22) == 0
        Enemy_shot::default o
      end
#          o.y += 0.05
      rect_delete o 
    end
  end # d

  def e0_right o
      e0 o , 330 , -50
  end
  def e0 o  , xx = nil , yy = nil
    oo = o
    tmp = o.class.new 
    tmp.d = $Scarlet.dd.enemy0
#        x , y = Lumia.get_xy_center( o , tmp )
    x = xx || 100
    y = yy || -50
    o.miko({ sym: :enemy , x: x , y:y, d: tmp.d , }) do |o|
      o.Init do
      end

      if o.y < 50
        o.y += 1
        next 
      end
      if rand(22) == 0
        Enemy_shot::default o
      end
      
      ccc = o.c
      case ccc
      when 100
        o.speed = 0.7
        o.angle = 135
      when 101...150
        o.angle += 0.1
      end
      rect_delete o 
    end
  end # d




  def e1 o , hs = Hash.new
    oo = o
    tmp = o.class.new 
    tmp.d = $Scarlet.dd.enemy0
#        x , y = Lumia.get_xy_center( o , tmp )
    x = hs[:x] || 100
    y = hs[:y] || -50
    o.miko({ sym: :enemy , x: x , y:y, d: tmp.d , }) do |o|
      o.Init do
      end

      if o.y < 50
        o.y += 1
        next 
      end
      
      ccc = o.c
      case ccc
      when 101...150
        if rand(22) == 0
          Enemy_shot::default o
        end
      when 200
        o.speed = 0.7
        o.angle = 90
      end
      rect_delete o 
    end
  end # d

#
#
#
#
#

  def e3 o , hs = Hash.new
    oo = o
    tmp = o.class.new 
    tmp.d = hs[:d] || $Scarlet.dd.enemy0
#        x , y = Lumia.get_xy_center( o , tmp )
    x = hs[:x] || 100
    y = hs[:y] || -50
    o.miko({ sym: :enemy ,x: x , y: y, d: tmp.d ,
    }) do |o|
#      init move
      if o.y < 50
        o.y += 1
        next 
      end
#      move
      ccc = o.c
      case ccc
      when 200
        o.speed = 0.7
        o.angle = 90
      end
# shot
     case ccc
     when 100,120,140,160
       Enemy_shot.shot_A o
     end
# msg
      rect_delete o 
    end
  end # d


end # m






#---------------------------------------------------------------------------
#
#
#
#
# --------------------------  enemy shot main ---------------------
#
#
#
#
#---------------------------------------------------------------------------



module Patchouli_Enemy_shot

  def default o
    [45].each_with_index { | m , i |
  # init
      tmp = o.class.new
      tmp.d = Image.new(10,40,[150,170,180,240])
      x , y = Lumia.get_xy_center( o , tmp )
      miko.miko({ sym: :enemy_shot , x: x , y: y,  d: tmp.d ,
      }) do |o|
  #      init move
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
        o.y += 1
        rect_delete o 
      end
    }
  end # d


# shot_A
#
#   　□
#　　／｜＼
#
  
  def shot_A o
    [-45,0,45,].each_with_index { | m , i |

      ang = Lumia.homing_angle o.x , o.y , user.x , user.y
      ang += m
  # init
      tmp = o.class.new
      tmp.d = Image.new(10,40,[150,170,180,240])
      x , y = Lumia.get_xy_center( o , tmp )
      miko.miko({ sym: :enemy_shot , x: x , y: y,  d: tmp.d ,
        angle: ang , speed: 1 ,
      }) do |o|
  #      init move
        if false
          next 
        end
  #      move
        ccc = o.c
        case ccc
        when 1..100
        end
  # shot
        case ccc
        when 1
        end
  # msg
        o.y += 1
        rect_delete o 
      end
    }
  end # d
  

end










module Patchouli_Enemy_shot
  
  # *2
  #
  # ccc  0..90 ↑
  # ccc  100..200   クロス
  # ccc  300..400   クロス
  # ↓
  #　　↓
  #

  def miu_closs2 o
    x , y , d = Yuka.center o , Image.load("img/dote/ms0.png")
    speed_1 = Yukarin.cc  2    , 0.1   , -0.01 
    speed_2 = Yukarin.cc  0.01  , 1.4   ,  0.01 
    hm      = Yuka.h_move_re
    n = 40
    rr = []
    [
     [ x     , y ] ,
     [ x + n , y ] ,
    ].flatten
    .each_slice(2).each_with_index { | ( x , y )  , i |
      miko.neko( :enemy_shot , x , y , d , ) do |o|
        case o.c
        when 0..90
          o.y -= speed_1.call
        when 91
          rr << [ o.x , o.y ]
          rr.reverse!
        when 298
          rr.clear
        when 299
          rr << [ o.x , o.y ]
          rr.reverse!
          hm = Yuka.h_move_re
        when 100..200  , 300..400
          if hm.call( o , rr[i][0] , rr[i][1] , 1 )
            hm = ->*h{ true }
          else
            next
          end
        end
        Yuka.move o , speed_2.call , 90
      end
    } # each
  end # d


  # *4
  #
  # ccc  0..90 ↑
  # ccc 100..200  , 280..380  クロス
  # ↓
  #　　↓
  #
  def miu_closs4 o

    x , y , d = Yuka.center o , Image.load("img/dote/ms0.png")
    speed_1 = Yukarin.cc  2     , 0.1   , -0.01 
    speed_2 = Yukarin.cc  0.01  , 1.4   ,  0.01 
    hm   = ->{} 
    hm_f = [false]*4  # hm_f.all? で使うので 最初から4つ確保
    rr   = []
    
    n = 40 ; [
     [ x     , y ] ,
     [ x + n , y ] ,
     [ x + n , y + n ] ,
     [ x     , y + n ] ,
    ].flatten
    .each_slice(2).each_with_index { | ( x , y )  , i |
      miko.neko( :enemy_shot , x , y , d , ) do |o|
        fn = -> {
          rr << [ o.x , o.y ]
          if rr.size == 4
             rr.rotate!(2)
             hm    = Yuka.h_move_re
             hm_f  = [false]*4
          end
        }
        case o.c
        when 0..90
          o.y -= speed_1.call
        when 99
          fn.call
        when 278
          rr.clear
        when 279
          fn.call
        when 100..200  , 280..380
          if hm.call( o , rr[i][0] , rr[i][1] , 1 )
             hm_f[i] = true
             if hm_f.all?
               hm = ->*h{ true }
             else
               next
             end
          else
            next
          end rescue nil
        end
        Yuka.move o , speed_2.call , 90
      end
    } # each
  end # d

#
#
#  angle 受け取って　うねうねうね
#
#
  def miu_angle_une o , hs = Hash.new
    ang   = hs[:angle] || 90
    speed = Yukarin.cc  0.01  , 1.4   ,  0.01 
    
    x , y , d = Yuka.center o , Image.load("img/dote/ms0.png")
    miko.neko( :enemy_shot , x , y , d , angle: ang , speed: 1) do |o|
      case ccc = o.c
      when 0..60
      when 62
         o.angle = 0
         o.speed = 0
      when 70..71
        ang = Yuka.h_user o
      end
      if ccc > 75
        Yuka.move o , speed.call , ang
      end

    end # neko
  end # d
#
#
# 中心点から広がって
# まるく広がっていく
# 
  def miu_circle o
    speed = Yukarin.cc  0.01  , 1.4   ,  0.01 

    x , y , d = Yuka.center o , Image.load("img/dote/ms1.png")
    ccc_up = 0
    nyan   = 10.step(360 , 10).to_a
    miko.neko( :effect , 0 , 0 , Yuyuko.dd) do |o|
      ccc_up = ccc = o.c

      o.delete if ccc > 1000  # 1000 フレームくらいたったら削除
      next if (ccc%5) == 0 
      next if nyan.empty?
      m = nyan.pop 
      miko.neko( :enemy_shot , x , y , d , angle: m , speed: 1) do |o|
        case ccc = o.c
        when 0..60
        when 62
           o.angle = 0
           o.speed = 0
        when 70..71
          ang = Yuka.h_user o
        end
        if ccc_up > 200
          Yuka.move o , speed.call , m + 200 
        end
      end # ko_neko
      
    end # oya_neko
    
  end # d

#
#　花びらくるくる　薄い花びら　エフェクト　　当たり判定なし
#
# 時間で alpha 255 になって　enemy_shot　　当たり判定あり
# 4方向に 進んでく
#
#
#
  def miu_hanabira o
    x , y , d = Yuka.center o , Image.load("img/dote/eff.png")
    ccc_up = 0
    nyan   = 45.times.map.to_a
    miko.neko( :effect , 0 , 0 , Yuyuko.dd) do |o|
      ccc_up = ccc = o.c

      o.delete if ccc > 2000  # 2000 フレームくらいたったら削除
      next if (ccc%5) == 0 
      next if nyan.empty?
      m = nyan.pop 

      x , y = rand(460)-20 , rand(300)+100
      hhs = ({
        alpha:  [ :default , 0 , 170 , 1 ] ,
        rot:    [ :default , 50 , 1200 , 2 ] ,
        scalex: [ :default , 0.5 , 1 , 0.01 ] ,
        scaley: [ :default , 0.5 , 1 , 0.01 ] ,
      })
      miko.neko( :enemy_shot , x , y , d , {angle: rand(360) , speed: 1}.merge(hhs) ) do |o|
        o.Init do
           o.str = o.sym
           o.sym = o.uniq_sym( :effect )
        end
        case ccc = o.c
        when 0..60
        when 62
           o.angle = 0
           o.speed = 0
        when 70..71
          ang = Yuka.h_user o
          m = [90,180,270,360].dmap.+(45).sample
        end
        if ccc_up == 300
           o.sym = o.str
           o.st.alpharemi = ->{ 255 } 
        end
        if ccc_up > 300
          Yuka.move o , 0.8 , m 
        end
      end # ko_neko
      
    end # oya_neko
    
  end # d

#
#
#
# ななめ2方向　　rand
#　　　■
#  ／ ＼
#
  def miu_naname2 o
    x , y , d = Yuka.center o , Image.load("img/dote/ms2.png")
    [45 , 135].dmap.+(rand(20)-10).each { | m |
      miko.neko( :enemy_shot , x , y , d , {angle: m , speed: 3} ) 
    } # each
  end

#
#
#
# ななめ4方向　　  h_user の周り　＋‐　２０　、　４０
#　　　■
#  ／ ＼
#


  def miu_naname4 o
    x , y , d = Yuka.center o , Image.load("img/dote/ms2.png")
    ang = Yuka.h_user o
    [40,20,-20,-40].dmap.+(ang).each { | m |
      miko.neko( :enemy_shot , x , y , d , {angle: m , speed: 3} )
    } # each
  end

#
#
#　　○　で　途中で　アングル+50
# 
#　　　■
#  miu_nyannnyannu
#
  def miu_nyannnyannu o
    x , y , d = Yuka.center o , Image.load("img/dote/ms2.png")
    30.step(390,30).each { | m |
      miko.neko( :enemy_shot , x , y , d , {angle: m , speed: 3} ) do | o |
        o.angle += 50 if o.c == 50
      end
    } # each
  end
  


  def kotohime_pattern_enemy_shot_0___ o , d  , speed , angle , &block
    x , y  = Yuka.center o , d
    pattern_0  o , {
      sym: :enemy_shot , d: d , x: x , y: y , speed: speed , angle: angle , 
    } , &block
  end
 


  def miu_kotohime_test o
    d   = Image.load("img/dote/ms2.png")
#    ang = Yukarin.cc 90 , 255 , 1
    ang = 
    Yakumo_ran.cc ({
      start: 80 ,
      limit: 200 ,
      add: 1 ,
    })
    spd = 
    Yakumo_ran.cc ({
      start: 0 ,
      limit: 2 ,
      add: 0.01 ,
    })
    pattern_0  o , d , spd , ang do | o |
    end
  end # d
end


