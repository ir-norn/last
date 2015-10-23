# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__


#
# chen
#　　　　　　　　　　　　　　　　　　　　　 __o　　　 o
#　　　　　　　　　　　　　　　　 　 　 　 'ｰ/＾＼ .ノ/ヽ、
# 　　　　　　　　　　　　　　 　　　 　　 　 i　 　|＼.!._ くヽ、
# 　　　　　,.､,. '" ￣￣ ﾞヽ､_　　　　　　　.>-]　￣ _r､_,.､r>
# 　　　　　l iヽ､__ゝ_,.-､_,.イﾉ　　　　　　ri　_,__,.イrｲ_!ｲ ﾉ
# 　　　　 <ﾍヽ､ﾝr_ﾉリ_ﾊリi　　　 　　　 ゝ'_r､,!イ! ｲlj.〈!ﾉ
# 　 　　　　Y ﾞイ　l | (ﾞlj〈ﾘ　　　　　　　　i ｲ　ヽ_ゝ" _ ﾉ　　　　　ちょっと式神シスターズが通りますよ
# 　 　　　　ﾊ　 　.| | "┌ﾉ　　　　.i＼.　ノレｲノ ハ-,イﾉ
# 　　　　 ノｲノ ﾉ ﾚゝ-イi　　　　　',　 ヽ､ﾍ, γ⌒'iﾞ>､'
# 　　　　　　'イγ⌒i}>i}　　　　_,..-ゝ､ 　ヽl i　　　,ゝ!､､
# 　- .,　　　　 /　 ､〉 ｀i〉　　＜_　　　ヽ､　',〈　　 ´　　,|l
# 　 　 ﾞヽ､　／　　 |_,__,〉　　　　 _.ﾆ=-　ヽ､/｀iｰ-r-イ/
# 　　　　_ﾞ,〈､___ 　_| / |_,>　　,_'"　　 　　／　,　　,'　=|
# 　 - ' ",.-,く(_ン´ /　 |ﾉ　 　　￣￣r-く-､ノ 　 //　(|
# 　　　 ﾉ　 〉-､ヽ､/_____ゝ　　　　　 ,' 　 〉ゝ>　く.(･∀lゝ
# 　　　ﾞｰ '"　　' ｰrﾆr_"´.　　　　　ﾞｰ '"　　 ｀'ｰ=;:rﾆ;r_"
# ;. 。　．.　:::::::::::::::[,_____)::　　:::::::::::::::::::::::::::::::::::::::::: [,_____)　_ε３
# :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
# 
#
#



module Yakumo_chen
  class Count
    attr_accessor :n
    attr_accessor :c
    def initialize n
      @n = n
      @c = 0
    end
    def call
      @c += 1
      if @c == @n
        @c = 0
        return true
      end
      return false
      
    end # d
    
    def copy_new
      self.class.new @n
    end

  end
  
  class << self
    def count_true n
      Count.new n
    end

    def siki  n
      Count.new  n
    end

  end
    
end

=begin
a = Yakumo_chen.count_true 5
10.times do |i|
  print i , "   "
  p a.call
end

=end






