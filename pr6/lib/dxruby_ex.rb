# dxruby �g��
require "__tewi/req"  if $0 ==__FILE__



#------------------------------------------
#
#  CollisionCircle �N���X�@�̊g��
#
#
#
#------------------------------------------




class CollisionCircle
  attr_accessor :mx , :my , :md , :o , :tmp
  alias set_2 set
  def set x , y

    @tmp.x = @o.x
    @tmp.y = @o.y
    @tmp.d = @md
    @mx , @my = Lumia.get_xy_center @o , @tmp

    return set_2 @mx , @my
  end
  alias initialize_2 initialize
  def initialize o , x , y , r
    @mx = x
    @my = y
                    r2 = r*2
    @md = Image.new(r2,r2).circle( r , r , r , [200 , 255,55,255] )
    @o  = o
    @tmp = Struct.new(:x,:y,:d).new

    initialize_2 o , x , y , r
  end
  def draw
    Window.drawEx @mx , @my , @md , { z: 50 }
  end
end




#------------------------------------------
#
#  �ꏊ�ɂ����ĕ��R�^�X�N�ŏ��������Ƃ��ׂ̈�loop2
#
#
#
#------------------------------------------

module Window
  class << self
    def loop2
      [nil].cycle do
        Window.sync
        Window.update
        exit if Input.update
        yield
      end
    end

  end
end



#------------------------------------------
#
#  Lumia.rb ��3�����z��Load�֐�
#
#
#
#------------------------------------------


# Image �� Sound �� ���[�h�֐����ꏏ�ɂ��邽�߂̋L�q
# Lumia.rb �Ŏg�p
class Sound
  def self.load s
    self.new s
  end
end
