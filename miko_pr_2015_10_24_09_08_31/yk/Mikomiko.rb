# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__

module Mikomiko_module
end

class Yuyukosama
  include Mikomiko_module
end

class Yuyukosama
  def neko sym , x , y , d , hs = Hash.new
    miko( {
       sym: sym , x: x , y: y , d: d ,
    }.merge(hs) ) do | o |
      yield o   if iterator?
    end # miko
  end # d
end


module Mikomiko_module
 # �������p
  module Miko_m
    def Init
      if @__miko_m_init.nil?
        @__miko_m_init = true
        yield
      end
    end
  end


  # �Œ���
  def miko__old  hs = Hash.new , &block


    o = self
    angle  = hs[:angle] || 0
    speed  = hs[:speed] || 0
    hs[:x] = hs[:x] || 0
    hs[:y] = hs[:y] || 0
    hs[:d] = hs[:d] || Yuyuko.dd
    sym = hs[:sym_uniq] || uniq_sym(hs[:sym])
    o.Task( sym ) do |o|
      remi     = Yukarin.fade_create o , hs
      o.extend Miko_m

      o.Code do
        remi.call
        o.x , o.y = Lumia.move o.x , o.y , speed , angle
        yield o if iterator?
      end # code //
    end # task //
  end # df

end



#
#
#
#
#�@�����������A�@�S�������ł��点��
# �^�X�N�@�����蔻���@���ӂ����Ɓ@���[���[�@�Ă��@�������Ɓ@
#-------------------------------------------
#

module Mikomiko_module

  def miko hs = Hash.new
    o = self
    nodelete = hs[:nodelete]  # rect

    angle  = hs[:angle] || 0
    speed  = hs[:speed] || 0
    hs[:x] = hs[:x] || 0
    hs[:y] = hs[:y] || 0
    hs[:d] = hs[:d] || Image.new(60,60,[100,140,200])
    sym = hs[:sym_uniq] || uniq_sym(hs[:sym])

#        p hs[:dd]
    o.Task( sym , hs ) do |o|

#      if hs[:dd].class == Array
#        hs[:d] = hs[:dd].first 
#      end

      o.extend Miko_m
      o.speed  = speed
      o.angle  = angle

      remi_ex = []
      remi_ex << ->{  Nazrin.rect_delete o }    if  not  nodelete

      lumia_move = ->{
        instance_exec o.speed , o.angle do | spd , ang |
          spd = o.speed.call if o.speed.respond_to?(:call)
          ang = o.angle.call if o.angle.respond_to?(:call)

#          p o.angle.class
#          if angle.respond_to?(:call)
#          end

          o.x , o.y = Lumia.move o.x , o.y , spd , ang    #  if ang != 0
        end
      }

      func = ->do
        remi_ex << lumia_move
        remi_ex << Yukarin.fade_create( o , hs )
        o.extend Nazrin
        o.var_add :collision
        o.collision = CollisionCircle.new( o , 0 , 0 , 5 )
        remi_ex << ->{ o.collision.draw if $Scarlet.izayoi }
      end
      effect = ->do
        remi_ex << lumia_move
        remi_ex << Yukarin.fade_create( o , hs )
      end

      case o.sym
      when /user_shot/
        func.call
        o.collision = CollisionCircle.new( o , 0 , 0 , 10 )

        o.life = 1
        o.atack = 1
      when /user/
        func.call
        o.life = 10
        o.atack = 1
      when /enemy_shot/
        func.call
        o.life = 1
        o.atack = 1
      when /enemy/
        func.call
        o.collision = CollisionCircle.new( o , 0 , 0 , 20 )

        o.life = 10
        o.atack = 1
      when /effect/
        effect.call
      when /item_tokuten/
        func.call
        o.life  = 1
        o.atack = 0
      when /item/
        func.call
        o.collision = CollisionCircle.new( o , 0 , 0 , 20 )

        o.life  = 1
        o.atack = 0

      when /task/
        # ���g�p?
      else
#         p o.sym
#         p "symbol_err"
      end
      # sound play
      #
      o.Code do
        remi_ex.map(&:call)
        yield o if iterator?

      end # code //
    end # task //
  end # df
end












__END__


          spd = o.speed.call if o.speed.instance_of?(Yakumo_ran::Count_limit) or
            o.speed.instance_of?(Proc)
          ang = o.angle.call if o.angle.instance_of?(Yakumo_ran::Count_limit) or
            o.angle.instance_of?(Proc)


            #        remi_ex << ->{ o.x , o.y = Lumia.move o.x , o.y , o.speed , o.angle if o.angle != 0 }
