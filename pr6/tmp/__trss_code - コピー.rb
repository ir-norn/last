#coding:utf-8


#p [false].any?
#3exit

require "yaml"
require "dxruby"

class Create_VK_action2
  attr_accessor :module
  def initialize profile
    @module = Module.new do
      self.define_singleton_method :extended do | mod |
        key_data = YAML.load open("./dat/keyconfig.yaml")
        [ :VK_Push? , :padPush? ,:keyPush? ,
          :VK_Down? , :padDown? ,:keyDown? ,
        ].each_slice(3) do | me , pad , key |
          mod.define_singleton_method me do | vk |
            key_data[ profile.to_s ][ vk.to_s ].any? do | m |
              Input.method(m=~/P_/?pad:key)[ key_data["dxruby_keycode"][m] ]
            end # any
          end # def_s
        end # each
      def Replay
      end
    end end # module.new self.extended
end end # class initialize

def Scene_event code ,*arg
  arg[0] == "profile0"
  case code
  when :VK_0
  when :VK_1
  when :VK_2
  end
end

count = 0
o =  Object.new
o.extend Create_VK_action.new("profile0").module

g=[ [false]*10,[true]*4].flatten.cycle
Window.loop do
  count += 1
  if g.next
    if o.VK_Down? :VK_3
      p :t
    end
  end
  p :test if o.VK_Push? :VK_0
  p :xxx  if o.VK_Down? :VK_1
  exit if Input.keyPush? K_F9
end


exit

hs = YAML.load_file("dat/keyconfig.yaml")
p hs
# p [*:VK_0..:VK_15,:VK_LEFT,:VK_UP,:VK_RIGHT,:VK_DOWN]
[*:VK_0..:VK_15,:VK_LEFT,:VK_UP,:VK_RIGHT,:VK_DOWN].each do |m|

end

exit
Window.loop do

  exit if Input.keyPush? K_F9
end
exit

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
