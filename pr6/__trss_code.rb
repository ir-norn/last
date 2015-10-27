#coding:utf-8

module Book
  def initialize(title)
    @title = title
  end
  def title5yr6h
    @title
  end
end

p Book.instance_methods(false)

exit

p Object.new.hash
p Object.new.hash
p Object.new.hash
p 1.hash


exit

p Proc.new

p a
p ->{}
p lambda{}
p main
exit
hs=Hash[1,2,3,4,5,6]
#hs.values.each &:display
#hs.each do|k,v| p k end.clear
#  p hs
module DEBUG
  def initialize
    p 1
    super
  end
end
class A
  def initialize
    p 2
    super
  end
  include DEBUG
end
A.new
exit

module A
  def f
    p 122
    super rescue p $!
  end
end

module C
  def f
    p 3
    super
  end
end

class B
  include A
  include C
  def f
    p 2
    super
  end
end
B.new.f



exit

class Game_Scene01_class
  def constructor
    Load_Gamen()
    @dat = "大きなデータ"
  end
  def mainloop
    Window.draw(0,0,@dat)
  end
  def message_proc code , argv = []
    case code
    when KEY_0
    when KEY_1
    when KEY_2
    when LOAD_START
      puts :ロード開始
    when LOAD_END
      puts :ロードend
    end
  end
end


module Game_Object01_mix
  def constructorx
    @dat = "データ"
  end
  def mainloop
    Window.draw(0,0,@dat)
  end
  def message_proc code , argv = []
    case code
    when EVENT01
    when EVENT02
    when EVENT03
    end
  end
end



class AnneRose_Title_main
  def main
    # 必要に応じてロード
    Data_Load
    img = "大きなデータ"
    p 435
  end
  def mainloop
    Window.drawFont(50,  10, "--AnneRose/title--" ,)
  end
  def Event_proc code
    case code
    when VK_0
    when VK_1
    when VK_2
    end
  end
end
