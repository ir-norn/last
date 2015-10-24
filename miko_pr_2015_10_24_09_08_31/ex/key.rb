# -*- encoding: UTF-8 -*-

require "__tewi/req"  if $0 ==__FILE__

require "dxruby"
require 'pp'
require "yaml"


# Input.setRepeat(20,4)

module Input_vkey
  def self.extended mod
  	@@system_key_profile = "profile0"
    @@Vk_Input   = Vk_Input.new @@system_key_profile
    @@dx_keycode = YAML.load open( "./dat/dxruby_keycode.yaml" ).read
    # pp dx_keycode
    file = "./dat/keyconfig.yaml"
    @@data = YAML.load open( file ).read
#    pp @@data
#    exit
  end
  def vkeyPush?  vk  , profile = @@system_key_profile
    if vk.class == Fixnum
#      p "obsolute, worning" , caller
      return keyPush? vk 
    end
    @@data[ profile.to_s ][ vk.to_s ].each do | m |
      key = @@dx_keycode[ m ] 
      if m =~ /P_/
        return true if padPush?( key )
      else
        return true if keyPush?( key )
      end
    end
    return false
  end

  def vkeyDown?  vk  , profile = @@system_key_profile
    if vk.class == Fixnum
#      p "obsolute, worning" , caller
      return keyDown? vk 
    end
    @@data[ profile.to_s ][ vk.to_s ].each do | m |
      key = @@dx_keycode[ m ] 
      if m =~ /P_/
        return true if padDown?( key )
      else
        return true if keyDown?( key )
      end
    end
    return false
  end

  def vkeyDownWait? key , wait 
    @@Vk_Input.vkeyDownWait? key , wait 
  end
  def vkeyDownWait2? key , wait , owait
    @@Vk_Input.vkeyDownWait2? key , wait , owait
  end

end # m

  # caller wo hash ni site joutai hozonn sinai to
  # loop de 2 kai yonnda toki ni 2bai soku ni naru kamo de su
class Vk_Input
  attr_accessor :profile
  def initialize profile
    @profile             = profile
    @keyDownWait         = Hash.new
    @keyDownWait.default = 0
    @keyDownWait2        = @keyDownWait.clone
  end
  def vkeyPush? vk
    Input.vkeyPush? vk , @profile
  end

  def vkeyDown? vk
    Input.vkeyDown? vk , @profile
  end
  def vkeyDownWait? key , wait 
    keyhs = @keyDownWait
    if Input.vkeyDown? key , @profile
          keyhs[ key ] += 1
    else  keyhs[ key ]  = 0
    end
    return true if keyhs[ key ] == 1
    return wait < keyhs[ key ] && ( keyhs[ key ] % wait == 0)
  end # kd
  def vkeyDownWait2? key , wait , owait
    keyhs = @keyDownWait2
    owkey = "ow_#{key}"
    if Input.vkeyDown? key , @profile
      if ( keyhs[ owkey ] == 0 ) || ( keyhs[ owkey ] < owait )
        keyhs[ owkey ] += 1
        return Input.vkeyPush? key
      end
          keyhs[ key ] += 1
    else  keyhs[ key ]  = 0
          keyhs[ owkey ] = 0
    end
    return wait < keyhs[ key ] && ( keyhs[ key ]% wait == 0)
  end # kd
end



module Input
  extend Input_vkey
end



=begin

n = Vk_Input.new "profile0"
Window.loop do
#  if Input.vkeyPush? :vk_down
  if n.vkeyDownWait? :vk_up , 22 
   p 23
  end
  if Input.vkeyDownWait? :vk1 , 22 
   p 23444
  end
  if Input.vkeyDown? :vk_down
   p 2
   exit
  end
end

=end




#
#
#
#
#  key up　
#
#
# Input.mupdate
#
# Input.mkey_up? K_Z


module My_Input

  @@__My_Input__key_wait  ||= Hash.new { |s,k| s[k] = [] }  
  @@__My_Input__key_stack ||= Hash.new { |s,k| s[k] = [] }  
  
  def mupdate
    kw    = @@__My_Input__key_wait
    stack = @@__My_Input__key_stack 




#   Input.keys
#    現在押されているキーのキー定数を配列にして返します。 
   # Input.keys が使えるらしい
    [
    # ---------------------- ちゃんと定数もってくる --------------
     K_Z , K_X ,
     K_Q , K_W , K_E , K_R ,
     K_DOWN , K_RIGHT , K_LEFT , K_UP ,
    ].each do |m|
      if Input.keyDown? m
        kw[ m ] = 1
      elsif kw[ m ] == 1
        kw[ m ] = 0
        stack[ m ] << true
      end
    end
  end

  def mkey_up? key
    @@__My_Input__key_stack[ key ].shift
  end
end

module Input
  extend My_Input
end



