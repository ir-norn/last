# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__


# ---------------------------------------- Patchouli_Knowledge ----------------------------------------


#
#
# �l�X�g���炷���߂�module��`
#
# ���^
=begin
module Enumerable 
  def hmap *h , &block
    src =  h.zip([:dmap].cycle).dmap.reverse.flatten.join"."
    ret = eval src
    if iterator?
      ret.map &block 
    else
      ret
    end
  end
end
=end

module Patchouli_Knowledge
  Nyan = [ :user , :user_shot , :enemy , :enemy_shot , :item , :effect ]
end
Patchouli_Knowledge::Nyan.dmap.capitalize
.zip(["Patchouli_"].cycle).hmap(:reverse , :join) do | m |
  eval "
  module #{m}
    include Patchouli_Knowledge
  end
  "
end

module Patchouli_Knowledge
#
# module
  instance_exec do
    pt   = Nyan.clone
    pt   << :miko  
    $Patchouli = Struct.new( *pt ).new # effect�͖��g�p
  end
  
#  p $Patchouli.method(:user=).call(44)
#  p  $Patchouli.user
  
  
  module Patchouli_sg

#
#   sg   effect �������܂̂Ƃ���Ȃ�
#
#
# setter
#
#
    def user_set o
      $Patchouli.user = o
    end
    def miko_set o
        $Patchouli.miko = o
    end
    def user_shot_set o
      $Patchouli.user_shot = o
    end
    #
    # all ������āA�@�z���Ԃ�  1�����~�������́@�@.sample
    #
    def enemy_set o
      $Patchouli.enemy = o
    end
    def enemy_shot_set o
      $Patchouli.enemy_shot = o
    end
    def item_set o
      $Patchouli.item = o
    end
#
# getter
#
    def miko
      $Patchouli.miko
    end
    def user
      $Patchouli.user
    end    

    def user_shot
      $Patchouli.user_shot
    end
# 
    def enemy
      $Patchouli.enemy 
    end
    def enemy_shot
      $Patchouli.enemy_shot
    end
    def item
      $Patchouli.item 
    end
  end # sg
  
  # -----------------------------------------------------
  #
  # Patchouli_Knowledge.user_set o  �Ȃǂŏ����������邽�߂�
  # ���كN���X��Patchouli_Knowledge ���g�����悤�ɂ���
  #
  class << self
    include Patchouli_sg
  end
  #
  # ------------------------------------------------------

  module Patchouli_kotohime_pattern
    #
    # ���̂ق��ł����`
    #
    # 
  end


# ----------------------------------------------------------------------------
#
# kotohime pattern_effect_0
# kotohime pattern_enemy_shot_0
#
# �Ȃǂ́A�I�u�W�F�N�g���Ƃɒ�`���ׂ� kotohime_pattern �̃��\�b�h�����^
#�@��{�I�Ƀ��\�b�h���ƁASymbol �݂̂��Ⴄ
#
#  +
#
# ���� Effect   Enemy   User  �Ȃǂ̎��̂ƂȂ�module�̒�`
#�@����̓��كN���X�̒�`�A�@��  Patchouli_sub ��
# Patchouli_User�@�Ȃǂ́A�l�X�g�h�~�p�̃��W���[����include������̂�
#
# User::default�@�Ȃǂ̃��\�b�h�̂͂����Ă� ���W���[���i ���كN���X �j �́A�����Œ�`�����
#
#
# ----------------------------------------------------------------------------
  module Patchouli_template_pattern 

    #  Patchouli_Knowledge::Patchouli_kotohime_pattern
    # 
    # moule Patchouli_Knowledge::User
    # �Ƃ�����@�@:user  �����o�����߂̃��\�b�h
    #
    def __self_sym
      self.to_s.split(/::/).last.downcase
    end
    
    # ----------------------
    #
    # ���܂�G��ׂ��炸�B
    #
    # ----------------------
    def method_missing name , *h , &block

        define_singleton_method  name  do | *h , &block |
          
          method_name = "kotohime_#{ name }"
          if not respond_to?( method_name )
            p "respond_to _ nil"
            p method_name
            p h
            p caller[2]
            exit if $de
          end
#          p name
#          p h.size

          if h.last.class == Hash
            hs = h.pop
          else
            hs = Hash.new
          end
#          o , d  , speed , angle  = h.shift 4
          o     = h.shift
          d     = h.shift
          speed = h.shift
          angle = h.shift
          

          if d.class == Array
            hs[:dd] = d
            d       = d.first
          end
#p d
#p speed
#p angle
#p o
          x , y  = Yuka.center o , ( d || Yuyuko.dd )
#p 2    
#          if respond_to?( "kotohime_#{ name }" )

          method( "kotohime_#{__method__}" ).call   o , *h , {
            sym:  __self_sym  , d: d , x: x , y: y , speed: speed , angle: angle , 
          }.merge(hs).value_compact , &block

      end
      # // singleton
      # call
      method( name ).call *h , &block
#    rescue => e
#      p __method__
#      p e

    end


=begin
    [ *:pattern_0..:pattern_2 ].each do | m |
      define_method m do | o , d  , speed , angle , *h , &block |
        x , y  = Yuka.center o , d
        hs = Hash.new
        if h.last.class == Hash
          hs = h.pop
        end
        method( "kotohime_#{__method__}" ).call   o , *h , {
          sym:  __self_sym  , d: d , x: x , y: y , speed: speed , angle: angle , 
        } , &block
      end
    end # e
=end


  end # temple_pat


  module Patchouli_sub
    def rect_delete o
      Nazrin.rect_delete o
    end # d 

    include Patchouli_sg
    include Patchouli_kotohime_pattern
    include Patchouli_template_pattern
  end # sub


  Nyan.dmap.downcase.each do |m|
    hanya =  "#{m}"
    m_ca  = m.capitalize
    ## #{m_ca} == Enemy_shot   �Ȃ�
    src   = <<-PATTERN
    module #{m_ca}
      class << self
        include Patchouli_sub
        include Patchouli_#{m_ca}

      end # c
    end # m
    PATTERN
#    puts src

    eval src
  end # e

#
#�@���^ �����܂Ł@///
#
#
#
#
#
#
# ---------------------------------------------------------------------------------

end # pm






# --------------------------------------------------------
#
# �p�^�[���L�q�p�̷����\�b�h�܂Ƃ�
# 
#  module Yuka
#
#
#
# --------------------------------------------------------

module Yuka_self_module
end
class Yuka
  class << self
    include Patchouli_Knowledge::Patchouli_sub
    include Yuka_self_module
  end # self
end # Yuka

module Yuka_self_module
  # Yuka
  #
  # def homing_move_create
  #
  #�@�@�W���ł�FALSE��Ԃ�
  #�@�@
  #�@�@�ړI�̍��W�ɒB������1�x����TRUE��Ԃ�
  #�@�@����ȍ~�͂�����FALSE
  #�@�@
  #�@�@�g���̂ăI�u�W�F�N�g�̂悤�Ȋ���
  #
  def homing_move_create_2 oo = nil
    phase = 0
    lambda do | o = oo , x , y , s |
      case phase
      when 0
        ang = Lumia.homing_angle o.x , o.y , x , y
        o.x , o.y = Lumia.move o.x , o.y , s , ang
        n = s * 1
        phase = 1 if Lumia.blockhit o.x , o.y , n , n , x , y , n , n
        return false
      when 1
        phase = 2
        return true
      when 2
        return false
      end # c
    end # lmd 
  end # d
  alias h_move    homing_move_create_2
  
  #
  #
  # TRUE �ɂȂ���ςȂ�
  #
  #

  def homing_move_create_re oo = nil
    phase = 0
    lambda do | o = oo , x , y , s |
      ang = Lumia.homing_angle o.x , o.y , x , y
      o.x , o.y = Lumia.move o.x , o.y , s , ang
      n = s * 1
      return true if Lumia.blockhit o.x , o.y , n , n , x , y , n , n
      return false
    end # lmd 
  end # d
  alias h_move_re    homing_move_create_re


#
#
#
#
#
# X �̂݁@Y �̂� ���B������ TRUE �ȃ��\�b�h�����肽�� 
#
# �܂�����m�F�Ȃ� ----------------------------------------------
#
#

  def homing_move_create_x oo = nil
    phase = 0
    lambda do | o = oo , x , y , s |
      ang = Lumia.homing_angle o.x , o.y , x , y
      o.x , o.y = Lumia.move o.x , o.y , s , ang
      n = s * 1
      width = Window.width
      return true if Lumia.blockhit o.x , 0 , width , n , x , 0 , width , n
      return false
    end # lmd 
  end # d

  def homing_move_create_y oo = nil
    phase = 0
    lambda do | o = oo , x , y , s |
      ang = Lumia.homing_angle o.x , o.y , x , y
      o.x , o.y = Lumia.move o.x , o.y , s , ang
      n = s * 1
      height = Window.height
      return true if Lumia.blockhit 0 , o.y , n , height , 0 , y , n , height
      return false
    end # lmd 
  end # d
#
# �܂�����m�F�Ȃ��@----------------------------------------------------------////
#
#
  
  

  #
  # �d�l�F homing_o_is_user
  #�@�@
  #�@�@�v���C���[�ւ̒��S���W�A���A���A���擾���A
  #�@�@���̍��W�ւ̃z�[�~���O�ׂ̈�angle��Ԃ�
  #
  def homing_o_is_user o
     x , y = Lumia.get_xy_center( user ,  o )
     angle = Lumia.homing_angle o.x , o.y , x , y
  end
  alias h_user  homing_o_is_user
  #
  #
  # move 
  #
  # o �� �Ƃ��� ���x�� angle ���w��
  #  
  def move o , s , a 
    o.x , o.y = Lumia.move o.x , o.y , s , a
  end
  #
  #
  # center 
  # o �� �摜��^����
  # ���S���W���Ƃ��Ă���@���ł� d ��߂�l�ɁB 
  #
  # o �́A�Ԃ��Ƃ����� ��4�ߒl�ɂȂ�������āA�����������̂ŁA�Ԃ��悤�ɂ��邩�͖���
  #  
  def center o , d
    x , y = Lumia.get_xy_center( o , d )
    [ x , y , d ]
  end


end

# --------------------------------------------------------
#
#
#
# �G�t�F�N�g�֘A�̂܂Ƃ�
#
#
# Himekaidou   __ sub class �� module
# --------------------------------------------------------
module Hatate
  class Imprint
    attr_accessor :inter , :rand , :num
    attr_accessor :size , :inter
    def initialize
      @draw_stack = []
      @interval   = 0
      @size       = 7
      @inter      = 7
    end
    def draw x , y , d , hs = Hash.new
      size       = @size # hs[:size]     || 7
      inter      = @inter # hs[:interval] || size
      ran        = @rand
      draw_stack = @draw_stack
      alp        = (180 / size)
      
      if ran
        if (@interval=(@interval+1) % inter ) == 0
          draw_stack.push [ x , y , d ]
        end
      else
        if (@interval=(@interval+1) % inter ) == 0
          draw_stack.push [ x , y , d ]
        end
      end
      
      if draw_stack.size > size
        draw_stack.shift
      end
      
      draw_stack.each_with_index do | (x , y , d) , i |
        Window.drawEx x , y , d , { alpha: alp*i }.merge(hs)
      end
    end
    alias call draw
    def clear
      @draw_stack.clear
    end
  end
end



# ---------------------------------------------------------------------
#
#
# Patchouli_Pat
#                �\���A���g�p
#
#
# ---------------------------------------------------------------------

module Patchouli_Pat

  def default o , hs = Hash.new

    d = hs[:d] || Yuyuko.dd
    x = hs[:x] || 100
    y = hs[:y] || 100

    miko.miko({ sym: :effect , x: x , y: y,  d: d ,
    }) do |o , x , y|
      
    end
  end

end


#
#
# ���̂���
#  �e�������p�̃V�[������肽��
#
#
=begin
module Tewi
  class Patchouli_knowledge
    def initialize o
      init o
      init2 o
    init_phace o
    end # initialize
    def init2 o
      
      o.miko({ sym: :patchouli_knowledge }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :patchouli_knowledge }) do | o |
        Window.drawFont(50,  10, "--Patchouli_Knowledge--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Patchouli_Knowledge
end # m

=end


# ---------------------------------------------------------------------------------
#
#
#  Patchouli_Knowledge::Patchouli_kotohime_pattern
#
#
#     Nyan = [ :user , :user_shot , :enemy , :enemy_shot , :item , :effect ]
#
#  ������̃��W���[�����ׂĂ���Ăяo�����master�p�^�[��
#
#
#
# ---------------------------------------------------------------------------------




module Patchouli_Knowledge
  module Patchouli_kotohime_pattern
#    def kotohime_pattern_0  o , hs = Hash.new , &block
#      miko.miko hs , &block
#    end # d

    #
    #
    # default
    #
    def kotohime_pattern_0  o , hs = Hash.new , &block
      ang = hs[:angle]
      spd = hs[:speed]
      miko.miko hs.merge({ speed: spd , angle: ang }) , &block
    end # d



    #
    #
    # default  n  wait
    #
    
    def kotohime_pattern_1 o , n , wait , hs = Hash.new , &block
      nn  =  Array 1...n
      ch  =  Yakumo_chen.count_true wait
      miko.miko do | o |
        next     if not ch.call
        o.delete if not nn.pop
        kotohime_pattern_0 o , hs
      end
    end # d
    #
    #
    #
    # step  drop 1
    # 0 �� 360  �Ȃǂ������o���Ă��܂��̂ŁA�ŏ��̊p�x�͎̂Ă�
    #
    def kotohime_pattern_2 o , n , hs = Hash.new , &block
      ang = hs[:angle]
      spd = hs[:speed]
      #
      # Yakumo_ran�@�n����Ă�����
      # �f�t�H���g�̃A���O�����ƂĂ���
      angle = ang
      if ang.respond_to?(:copy_new)
         angle = ang.copy_new.call
      end
      #
      nya = ang
      angle.to_i.step_uniq( 360 + angle , 360 / n ) do | ang |
         spd = spd.copy_new                              if spd.respond_to?(:copy_new)
         ang = nya.copy_new  nya.hs.merge( start: ang )  if nya.respond_to?(:copy_new)
         miko.miko( hs.merge( speed:  spd  , angle: ang ) , &block  ) 
      end
    end # d
    #
    #------------------------------------------------------
    #
    #  kotohime_pattern_2  n  wait
    #
    #
    #
    def kotohime_pattern_3 o , n , wait , hs = Hash.new , &block
      nn  =  Array 1...n
      ch  =  Yakumo_chen.count_true wait
      miko.miko do | o |
        next     if not ch.call
        o.delete if not nn.pop
        kotohime_pattern_2 o , n , hs
      end
    end # d




    def kotohime_pattern_4  o , n , start , en , hs = Hash.new , &block
      ang = hs[:angle]
      spd = hs[:speed]

      nya = ang

#      nn = n == 1 ? n : n - 1
      e = start.step_uniq( en , (en-start) / n )
#      start.step_uniq( en , (en-start) / nn ) do | ang |
      n.times do
        ang = e.next
        spd = spd.copy_new                             if spd.respond_to?(:copy_new)
        ang = nya.copy_new  nya.hs.merge( start: ang ) if nya.respond_to?(:copy_new)
        miko.miko hs.merge({ speed: spd , angle: ang }) , &block
      end
    end


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

    # ����ang
    def kotohime_pattern_6  o , n , rel , hs = Hash.new , &block
      ang = hs[:angle]
      spd = hs[:speed]

      nya = ang

      if ang.respond_to?(:copy_new)
        start = ang.copy_new.call
      else 
        start = ang
      end

      e = start.step( Float::INFINITY , rel )
      n.times do | i |
        ang = e.next
        spd = spd.copy_new                            if spd.respond_to?(:copy_new)
        ang = nya.copy_new nya.hs.merge( start: ang ) if nya.respond_to?(:copy_new)
        
#        ang += rel
        miko.miko hs.merge({ speed: spd , angle: ang }) , &block        
      end
    end

    def kotohime_pattern_7  o , n , wait , rel , hs = Hash.new , &block
      nn  =  Array 1...n
      ch  =  Yakumo_chen.count_true wait
#      ch  =  Yakumo_yukari.ch wait
      miko.miko do | o |
        next     if not ch.call
        o.delete if not nn.pop
        kotohime_pattern_6 o , n ,rel , hs , &block
      end
    end



    def kotohime_shot2 o , hs = Hash.new , &block
      d     = hs[:d]
      x , y = hs[:x] , hs[:y]
      [
        x + o.d.width / 2 , y ,
        x - o.d.width / 2 , y ,
      ].each_slice(2) do | x , y |
        miko.miko hs.merge( x: x , y: y ) , &block
      end # times 
    end # d 






  end # m
end # pm















