# dxruby 拡張
require "__tewi/req"  if $0 ==__FILE__


#--------------------------------------
#
#   module Nazrin
#     include Collision_hit_shot
#
#------------------------------------------
module Collision_hit_shot
  def hit o
    hit_shot o
  end
  def shot o
    hit_shot o
  end
end






#------------------------------------------
#
#  CollisionCircle クラス　の拡張
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
#  場所によって平坦タスクで処理するときの為のloop2
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
    #
    def drawFont2 x , y , s , hs = Hash.new
      drawFont x , y , s , Yuyuko.font , hs
    end
  end
end



#------------------------------------------
#
#  Lumia.rb の3次元配列Load関数
#
#
#
#------------------------------------------


# Image と Sound の ロード関数を一緒にするための記述
# Lumia.rb で使用
class Sound
  def self.load s
    self.new s
  end
end











