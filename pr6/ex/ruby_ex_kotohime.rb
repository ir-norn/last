# -*- encoding: UTF-8 -*-

require "__tewi/req"  if $0 ==__FILE__

# ruby 拡張
#
# ゲーム製作用
#
#



# ----------------------------------------------
# 
#  Field __  step_uniq
#
#  同じ角度での2重生成の防止
#
#  720 ↑ とかのは考慮してない
#
#
# -----------------------------------------------
class Integer
  def step_uniq *h , &block
    step( *h ).map do | m |
      next m - 360 if m >= 360
      m
    end.uniq.map &block
  end
end




