# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

require "./in/field_nil_sub"


module Patchouli_User_shot

end #  us



module Patchouli_Enemy
  def boss1_test o , hs = Hash.new

    d = hs[:d] || Yuyuko.dd
    x = hs[:x] || 100
    y = hs[:y] || 100
    d = Image.load("img/dote/marisa0.png")
      d   = Image.load("img/dote/ms2.png")
      
    an = 0.step(360,10).cycle

    miko.miko({ sym: :enemy , x: x , y: y,  d: d ,
    }) do |o , x , y|
      o.Init do
        o.life = 20
      end
      s = 2
      if $de
        if Input.keyDown? K_J
          o.y -= s
        end
        if Input.keyDown? K_N
          o.y += s
        end
        if Input.keyDown? K_B
          o.x -= s
        end
        if Input.keyDown? K_M
          o.x += s
        end
        Input.setKeyRepeat( K_K , 10 , 5 )
        if Input.keyPush? K_K
          Enemy_shot::miu o
        end

        Input.setKeyRepeat( K_I , 10 , 5 )
        if Input.keyPush? K_I
          Enemy_shot::pattern_2 o , d , 2 , an.next ,  10
        end

     
      end

      ccc = o.c
      case ccc
      when 1 
        Enemy_shot::miu o
      end
      10.step(360 , 10) do |m|
        if ccc == m
#          Enemy_shot::miu o , angle: m
        end
      end
      
    end # miko
  end
end


  

module Patchouli_Enemy_shot 

  def maruuuu0 o
    d   = Image.load("img/dote/ms2.png")
    nya =  Yakumo_ran.cc  0 , 5 , 0.01 
    if rand(2) == 0
      an  =  Yakumo_ran.cc  90 , 875 , 1
    else
      an  =  Yakumo_ran.cc  900 , 8 , -1
    end
    pattern_4  o , d , nya , an ,   4 ,  rand(360) ,  rand(360)+360
  end
  def testtt o
    d   = Image.new(20,20,[200,250,220])
    nya =  Yakumo_ran.cc   0 ,   5 , 0.01 
    an  =  Yakumo_ran.cc  90 , 875 , 1

    an  =  Yakumo_yukari.cc  90 , 875 , 1
    p an.next
        

    pattern_4  o , d , nya , an ,   4 ,  10 , 180   
  end
#
#  lumia  i _ 　独自のかた　　クラス　定義して　返したほうがいいかもしれない
#

  
  
  def miu2 o
    

#    an.copy_new

#    exit
    
    testtt o

    return


#    testtt o
#    return
    d   = Image.load("img/dote/ms2.png")
    d   = Lumia.Image_load("img/dote/ms2.png")

    dd   = Lumia.i_miko "img/shot/0"

#    d   = "sfsdf" 
#          40.times do 
#          end
#     exit
# d = "にゃん"
#    Effect::pattern_1   o , d , 2 , 90 ,  8 ,  20 do |o|
#      o.x -= 1 
#    end

      nya =  Yakumo_ran.cc  0 , 5 , 0.01 

      an  =  Yakumo_ran.cc  90 , 875 , 0.2

#      ch = Yakumo_chen.count_true  o.d_p || 20
  #    pattern_0 o , d , 0.1 , 190
 #     pattern_0 o , d.copy_new , 0.1 , 290
#      pattern_0 o , d.copy_new , 0.1 , 90
      rr *[o , dd , 2 , an ] , 5 , 40 ,  0 , 80 , { alpha: [:default,77,255,1] }
      

#      aaa o , d , 2 , 90

      shot2 o , d , 2 , 90
      
      ne = Image.load("img/dote/ms2.png")
      bb = Lumia.i_miko "img/dote"
#      miko.neko( :effect , 100 , 300 , ne , { dd: bb } )
=begin
      pattern_5 *[o , d , 2 , an ] , 5 , 40 ,  0 , 80 , {
        alpha: [:default,77,255,1] ,
        dd: dd ,
        } do | o |
          o.str ||= 0
          if  (o.str+=1)%20 == 0# ch.call
            o.n = (o.n+1)%3
          end  
#          o.d = dd [ o.n ]
      end
=end
  1.times do
      pattern_3 o , d , nya , an , 6 , 30
      pattern_3 o , d , 2 , 130 , 6 , 30

      pattern_2 o , d , nya , an ,  3 
      pattern_2 o , d , 2 , 120 ,  3 

      pattern_1 o , d , nya , 190 ,10 , 3 
      pattern_1 o , d , 2 , 90   , 10 , 3
      pattern_0 o , d , nya , 90  
      pattern_0 o , d , 2 , 90 do|o|
        o.speed = 0.2
      end
      
  end   if false

#    pattern_0 o , d , 2 , 90   do |o|  end
#    pattern_1 o , d , 2 , 90 ,  8 , 20 do |o|  end
#    pattern_2 o , d , 2 , 90 ,  8  do |o| o.x += 1 end
#    pattern_3  o , d , 1 , 000 , 5 , 20 , {
#    alpha: [ :default ,  0 , 255 , 1] , } do | o |  end
  end

  def maru2 o
     d = Image.load("img/dote/ms2.png")
    [
     [ 0  , 360 , 0.5  ] , 0..20 ,
     [ 360  , 0 , -0.5 ] , 0..20 ,
    ].each_slice(2) do | yakumo , start ,    nn |
      nn = Yakumo_yukari.ch 300
      o.miko do | v |
        next if start === v.c
        next if not nn.next      
        an  =  Yakumo_ran.cc( *yakumo )
        pattern_7 *[o , d , 2 , an ] , 6 , 20 , 45 , &->o{
           o.angle = o.angle.call if o.c == 120 }
      end
    end # e
  end




def danmak_debug o
    sstr = methods.sort - Class.methods
    sstr.reject! { |m|
      method(m).arity != 1 or
      m == __method__ or
      m =~ /set/
    }
#    p sstr
#    exit
    remi = Yukarin.key_focus_create2

    miko.miko do
      n = remi.call  sstr.size , K_8  , K_9 , n , 6 , 4
      if Input.keyPush? K_L    
        method( sstr[n] ).call o rescue p $!
#         method(:maru2).call o
      end
      if Input.keyPush? K_U
        o.task.each do | k , v | v.delete end
      end
      
      focus = n
      space = 20
      str_p = ">>"
      font = Yuyuko.font3_20
      xx = 50
      fx = 15
      hss = { :z => -2 ,  :alpha => 140 , :color => [220,200,220] }  
      # main
      sstr.rotate(focus).each_with_index do| m , i |
        yy = 50+i*space
        if  i  == 0
          Window.drawFont(xx   , yy + (fx*space) , m.to_s ,font , { color: [100,100,200] , } )
          Window.drawFont(xx-(font.get_width(str_p)), yy + (fx*space) , str_p   ,font , { color: [100,100,200] , } )
        else
          Window.drawFont(xx , yy + (fx*space) ,  m.to_s , font , hss )
        end
      end
      # ue
      sstr.rotate(focus)[-fx..-1].each_with_index do| m , i |
        yy = 50+i*space
        Window.drawFont(xx , yy + (0*space) , m.to_s ,font  , hss  )
      end
      #sita
      if focus > (sstr.size-10)
        sstr[0..10].each_with_index do| m , i |
          i += ( sstr.size - focus )
          yy = 50+i*space
          Window.drawFont(xx , yy + (fx*space) , m.to_s ,font , hss  )
        end
      end

      
      
    end


end

  def danmak_0 o , d
     pattern_2 o , d , 2 , 90 ,  10
     pattern_2 o , d , 2 , 90-45/2 ,  10
  end

  def danmak_1 o , d 
     pattern_2 o , d , 2 , an.next ,  10
  end

  def miu o

     d = Image.load("img/dote/ms2.png")
#     pattern_2 o , d , 2 , 90 ,  3
#    pattern_5 *[o , d , 2 , nil ] , 2 , 40 ,  90 , 160

# danmak_1 o,d


#     pattern_2 o , d , 2 , 90 ,  5

#    danmak_debug o
    # maru2 o

#    return
 return
      bb = Lumia.i_miko "img/dote"
#      miko.neko( :effect , 100 , 300 , 4 , { dd: bb } )

#     shot2 o , d , 2 , 90
 
  end


    def kotohime_rr  o , n , wait , start , en , hs = Hash.new , &block
      nn  =  Array 1...12
      ch  =  Yakumo_chen.count_true wait
      miko.miko do | o |
        next     if not ch.call
        o.delete if not nn.pop
        kotohime_pattern_4 o , n , start , en , hs , &block
      end
    end

end




module Patchouli_Knowledge
  # -------------------------------------------------
  #
  # method_missing で　pattern_0　などは宣言される
  #
  #　ここにかかれた　kotohime_pattern_　メソッドは直接呼ばれない
  #
  # -------------------------------------------------
  module Patchouli_kotohime_pattern



=begin
    def kotohime_pattern_5  o , n , wait , start , en , hs = Hash.new , &block
      nn  =  Array 1...n
      ch  =  Yakumo_chen.count_true wait
#      ch  =  Yakumo_yukari.ch wait
      miko.miko do | o |
        next     if not ch.call
        o.delete if not nn.pop
        kotohime_pattern_4 o , n , start , en , hs , &block
      end
    end
=end

  end # m


end # pm




