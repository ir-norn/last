#coding:utf-8

require "yaml"
require "dxruby"
require "pp"

if $0 == __FILE__
  Dir.chdir File.dirname $0
end


#
# keys = Input.keys - old_keys
# keys.each.with_index do |s, i|
#   p keys_hash[s]
# end


module Create_VK_actionxxx
  def self.my_exec arg
    define_method(:func){ p "hallo "+arg }
    self
  end
end

o = Object.new
o.extend Create_VK_actionxxx.my_exec("test")
# o.func

module Create_VK_action_m
  def VK_Replay_update;end # Create_VK_action_ex
  def self.arg profile
    key_data = YAML.load open("./dat/keyconfig.yaml")
    [ :VK_Push? , :padPush? ,:keyPush? ,
      :VK_Down? , :padDown? ,:keyDown? ,
    ].each_slice(3) do | me , pad , key |
      define_method me do | vk |
        key_data[ profile ][ vk ].any? do | m |
          Input.method(m=~/P_/?pad:key)[
            DXRuby.constants.inject({}){|r,s|s=~/K_|P_/&&r[s]=DXRuby.const_get(s);r}[m] ]
        end
      end # mod
    end # each
    self
  end
end


class Create_VK_action
  attr_accessor :module
  def initialize profile
    @module = Module.new do
      def VK_Replay_update;end # Create_VK_action_ex
      self.define_singleton_method :extended do | mod |
        key_data = YAML.load open("./dat/keyconfig.yaml")
        [ :VK_Push? , :padPush? ,:keyPush? ,
          :VK_Down? , :padDown? ,:keyDown? ,
        ].each_slice(3) do | me , pad , key |
          mod.define_singleton_method me do | vk |
            key_data[ profile ][ vk ].any? do | m |
              Input.method(m=~/P_/?pad:key)[
                DXRuby.constants.inject({}){|r,s|s=~/K_|P_/&&r[s]=DXRuby.const_get(s);r}[m] ]
            end
          end # mod
        end # each
      end # extended
    end # module.new
end end # class initialize


class Create_VK_action_ex
  attr_accessor :module
  def initialize profile , save_file , action
    @module = Module.new do
# share var ----
      flame = 0
# --- SAVE ---
      save = -> profile , vk do
          keyhs = Hash.new ; keyhs.default_proc =->h,k{h[k]=[]}
          [*:VK_0..:VK_15,:VK_LEFT,:VK_UP,:VK_RIGHT,:VK_DOWN]
          .each do|vk| keyhs[vk] << nil end
             keyhs[vk] << flame
             data = {
                   :VK_log=> keyhs }
             open( save_file ,"w") do|f|YAML.dump(data,f)end
        end
# --- REPLAY ---
      if action == :replay
        key_save_data = YAML.load open(save_file)
      end # if
# --- share ---
      self.define_singleton_method :extended do | mod |
        key_data = YAML.load open("./dat/keyconfig.yaml")
        [ :VK_Push? , :padPush? ,:keyPush? ,
          :VK_Down? , :padDown? ,:keyDown? ,
        ].each_slice(3) do | me , pad , key |
          mod.define_singleton_method me do | vk |
# ---REPLAY ---
            if action==:replay;
              return key_save_data[:VK_log][vk].include?(flame)
            end
# --- ///REPLAY  リプレイ関係ここまで ----

# --- SAVE --- & action == nil ///  ここが唯一 falseの可能性ある場所
            return if not key_data[ profile ][ vk ].any? do | m |
              Input.method(m=~/P_/?pad:key)[
                DXRuby.constants.inject({}){|r,s|s=~/K_|P_/&&r[s]=DXRuby.const_get(s);r}[m] ]
            end
# --- SAVE ---
            if action==:save;save.call(profile, vk) end
# --- SAVE --- & action == nil / return
            return true
          end # mod
        end # each
# --- SAVE --- REPLAY ---
        mod.define_singleton_method :VK_Replay_update do flame+=1 end
      end # extended
    end # module.new
end end # class initialize



o =  Object.new
o.extend Create_VK_action_m.arg(:profile0)
# o.extend Create_VK_action.new(:profile0).module
#o.extend Create_VK_action_ex.new(:profile0 , "./dat/replay/replay1.yaml" , :save).module
#o.extend Create_VK_action_ex.new(:profile0 , "./dat/replay/replay1.yaml" , :replay).module

g=[ [false]*10,[true]*4].flatten.cycle
Window.loop do
 o.VK_Replay_update
  if g.next
    if o.VK_Down? :VK_3
      p :t
    end
  end
  p :vk0  if o.VK_Push? :VK_0
  p :vk1  if o.VK_Down? :VK_1
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
