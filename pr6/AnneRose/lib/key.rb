#coding:utf-8

require "yaml"
require "dxruby"
require "pp"

if $0 == __FILE__
  Dir.chdir File.dirname $0
end


# module Create_VK_action_mxxxxxx
#   def VK_update;end # Create_VK_action_ex
#   def self.arg profile
#     key_data = YAML.load open("./dat/keyconfig.yaml")
#     [ :VK_Push? , :padPush? ,:keyPush? ,
#       :VK_Down? , :padDown? ,:keyDown? ,
#     ].each_slice(3) do | me , pad , key |
#       define_method me do | vk |
#         key_data[ profile ][ vk ].any? do | m |
#           Input.method(m=~/P_/?pad:key)[
#             DXRuby.constants.inject({}){|r,s|s=~/K_|P_/&&r[s]=DXRuby.const_get(s);r}[m] ]
#         end
#       end # mod
#     end # each
#     self
#   end
# end


module Create_VK_action_m
  def self.arg profile , save_file = "./dat/replay/__default_replay.yaml"
    flame = 0 ; define_method :VK_update do flame+=1 end
    keyhs = Hash.new ; keyhs.default_proc =->h,k{h[k]=[]}
    [*:VK_0..:VK_15,:VK_LEFT,:VK_UP,:VK_RIGHT,:VK_DOWN]
      .each do|vk| keyhs[vk] << nil end
    save =-> profile , vk do
       keyhs[vk] << flame
       data = { :VK_log => keyhs }
       open( save_file ,"w") do|nyan| YAML.dump(data , nyan) end
       return true
    end
    key_data = YAML.load open("./dat/keyconfig.yaml")
    [ :VK_Push? , :padPush? ,:keyPush? ,
      :VK_Down? , :padDown? ,:keyDown? ,
    ].each_slice(3) do | me , pad , key |
      define_method me do | vk |
        key_data[ profile ][ vk ].any? do | m |
          save.call(profile, vk) if Input.method(m=~/P_/?pad:key)[
            DXRuby.constants.inject({}){|r,s|s=~/K_|P_/&&r[s]=DXRuby.const_get(s);r}[m] ]
        end
      end # mod
    end # each
    self
  end
end

module Create_VK_action_replay
  def self.arg profile , save_file
    flame = 0 ; define_method :VK_update do flame+=1 end
    key_save_data = YAML.load open(save_file)
    [:VK_Push?,:VK_Down?].each do |me|
      define_method me do |vk|
        key_save_data[:VK_log][vk].include?(flame)
      end
    end
    self
  end
end


o =  Object.new
o.extend Create_VK_action_m.arg(:profile0,"./dat/replay/replay1.yaml")
# o.extend Create_VK_action_replay.arg(:profile0,"./dat/replay/replay1.yaml")

g=[ [false]*10,[true]*4].flatten.cycle
Window.loop do
 o.VK_update
  if g.next
    if o.VK_Down? :VK_3
      p :t
    end
  end
  p :vk0  if o.VK_Push? :VK_0
  p :vk1  if o.VK_Down? :VK_1
  exit if Input.keyPush? K_F9
end
