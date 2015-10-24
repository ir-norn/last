# -*- encoding: UTF-8 -*-



require "__tewi/req"  if $0 ==__FILE__

# *----------------------------------------------------------*
#
#
#      重要な ruby 拡張
#
#
# *----------------------------------------------------------*

class << self
  def to_s
    %@幽々子様ほんとに可愛い@
  end
end
# p self

#
#
# Symbol　使いすぎると爆発するので、タスクのsymは文字列にした
# けどSymbolでもアクセスしたいので、、その為のメソッド
#
# 動作変、
# ちょっと使用するのは様子見
#
=begin
class Hash
  alias _saigyouji_yuyukosama_tyann! []
  
  def [] n
    p self
    p n
    if n.class == Symbol
      n = n.to_s
    end
    p n
    _saigyouji_yuyukosama_tyann! n
  end
  
end
=end

=begin
a =  { "s" => 5 }
p a["s"]
p a[:s]
p a[345]
=end



