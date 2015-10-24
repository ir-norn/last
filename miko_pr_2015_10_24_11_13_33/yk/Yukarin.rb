# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__


#
# count_loop_wait_create
#
# Yakumo_ran.rb に実装
#
#

# -------------------- count_lambda --------------------- #
module Yukarin
  def self.key_focus_create2 p = 0
    lambda do |size , key0 , key1 , pp = nil , *h |
      p = pp || p
      p = (p-=1) % size if Input.vkeyDownWait2?( key0 , *h)
      p = (p+=1) % size if Input.vkeyDownWait2?( key1 , *h)
      return p
    end
  end
  class << self
    alias kcc key_focus_create2
  end

  def self.key_focus_create p = 0
    lambda do |size , key0 , key1 , pp = nil |
      p = pp || p
      p = (p-=1) % size if Input.vkeyPush?( key0 )
      p = (p+=1) % size if Input.vkeyPush?( key1 )
      return p
    end
  end

  def self.key_focus_create_test p = 0
    lambda do |size , key0 , key1 , pp = nil , met = :keyPush? |
      p = pp || p
      p = (p-=1) % size if Input.method( met ).call( key0 )
      p = (p+=1) % size if Input.method( met ).call( key1 )
      return p
    end
  end
  # 0...1...2...3...4...5...6
  def self.count_limit_create  c , limit , add
#    start , limit = limit , start if add < 0
#    c = 
    if add > 0
    # plus
      return lambda do
        c += add
        c = limit if c >= limit
        return c
      end
    else
    # minus
      return lambda do
        c += add
        c = limit if c <= limit
        return c
      end
    end
  end
  # 0...1...2...3...4...0...1...2...3...4
=begin
# 降順 未対応
  def self.count_loop_create  start , limit , add
    c = start
    start , limit = limit , start if add < 0
    lambda do
      c += add
      c = start if c >= limit
      return c
    end
  end
=end
  # 0...1...2...3...4...3...2...1...0
  def self.count_loop_create  start , limit , add
    c = start
    lambda do
      c += add
      if add < 0
        c = start if c <= limit
      else
        c = start if c >= limit        
      end
      return c
    end
  end

  def self.count_loop_rev_create  start , limit , add
    c = start
    start , limit = limit , start if add < 0
    lambda do
      c += add
      add *= -1 if c >= limit || c <= start
      c = limit if c >= limit
      c = start if c <= start
      return c
    end
  end

  def self.count_select type
    case type
      when nil
        return lambda do | *h | lambda do | *hh | end  end
      when :default
        return lambda do | *h | count_limit_create *h end
      when :loop
        return lambda do | *h | count_loop_create *h end
      when :loop_rev
        return lambda do | *h | count_loop_rev_create *h end
    end
  end
  
  # todo
  # hash ni
  # blend   add
  #
  def self.__fead_inout_create_sub o , hs = Hash.new
     [ :rot , :scalex , :scaley , :alpha ]
     .each do |m|
       if hs[m].class == Array
         au = hs[m].clone
         hs[m] = Hash.new
         hs[m][:type]  = au[0]
         hs[m][:start] = au[1]
         hs[m][:limit] = au[2]
         hs[m][:add]   = au[3]
       end
     end

     o.x      = hs[:x] 
     o.y      = hs[:y] 
     o.d      = hs[:d] 
     o.st.fade_z   = hs[:z] || 0
     hs_rot    = hs[:rot]    || Hash.new
     hs_scalex = hs[:scalex] || Hash.new
     hs_scaley = hs[:scaley] || Hash.new
     hs_alpha  = hs[:alpha]  || Hash.new
     
     o.st.rot_hik    = ({  type:  hs_rot[:type]     || :default , start:  hs_rot[:start]    || 0   , limit:  hs_rot[:limit]    || 0 , add: hs_rot[:add]    || 0 })
     o.st.scalex_hik = ({  type:  hs_scalex[:type]  || :default , start:  hs_scalex[:start] || 1   , limit:  hs_scalex[:limit] || 1 , add: hs_scalex[:add] || 0 })
     o.st.scaley_hik = ({  type:  hs_scaley[:type]  || :default , start:  hs_scaley[:start] || 1   , limit:  hs_scaley[:limit] || 1 , add: hs_scaley[:add] || 0 })
     o.st.alpha_hik  = ({  type:  hs_alpha[:type]   || :default , start:  hs_alpha[:start]  || 255 , limit:  hs_alpha[:limit]  || 0 , add: hs_alpha[:add]  || 0 })
     create_remilambda = lambda do | hs |
       self.count_select(hs[:type]).call   hs[:start] , hs[:limit] , hs[:add]
     end
     o.st.rotremi     =  create_remilambda[ o.st.rot_hik    ]
     o.st.scalexremi  =  create_remilambda[ o.st.scalex_hik ]
     o.st.scaleyremi  =  create_remilambda[ o.st.scaley_hik ]
     o.st.alpharemi   =  create_remilambda[ o.st.alpha_hik  ]
     
     font = hs[:font] || Yuyuko.font
# --------------     --------------------------------------------------------------
#     dd = o.d.copy_new rescue nil
#     n = 0
#     ch = Yakumo_chen.count_true  o.d_p || 20
# Window.draw_Lumia の 定義を考える

# -------------------
     lambda do 
        o.st.rot     = o.st.rotremi.call
        o.st.alpha   = o.st.alpharemi.call
        o.st.scalex  = o.st.scalexremi.call
        o.st.scaley  = o.st.scaleyremi.call
        if o.dd.first
          Window.drawEx( o.x , o.y, o.dd_get , ({ :angle => o.st.rot, :alpha => o.st.alpha,
               :scalex => o.st.scalex, :scaley => o.st.scaley , :z => o.st.fade_z }) )           

        elsif o.d.class == Image
          Window.drawEx( o.x , o.y, o.d, ({ :angle => o.st.rot, :alpha => o.st.alpha,
               :scalex => o.st.scalex, :scaley => o.st.scaley , :z => o.st.fade_z }) ) 
#        elsif o.d.class == Lumia_I
# -------------------------------------------------------------------------
#          if ch.call
#            n = (n+1)%3
#          end
#          Window.drawEx( o.x , o.y, o.d.img[ n ] , ({ :angle => o.st.rot, :alpha => o.st.alpha,
#               :scalex => o.st.scalex, :scaley => o.st.scaley , :z => o.st.fade_z }) ) 
#          Window.drawEx( o.x , o.y, o.d.dd , ({ :angle => o.st.rot, :alpha => o.st.alpha,
#               :scalex => o.st.scalex, :scaley => o.st.scaley , :z => o.st.fade_z }) ) 
# ----------------------------------------------------------------------------------
        end
# 画像に書き込む形がいいかもしれない
#        if o.text
#          Window.drawFont( o.x , o.y, o.d, font , ({ :angle => o.st.rot, :alpha => o.st.alpha,
#               :scalex => o.st.scalex, :scaley => o.st.scaley , :z => o.st.fade_z }) )           
#        end

     end
  end # def
  class << self
    alias fade_create  __fead_inout_create_sub
    alias cc  count_limit_create
    alias lo  count_loop_create
    alias lr  count_loop_rev_create
  end
end

#
=begin
# fade_create 　__fead_inout_create_sub　に1個仲介させて、　Arrayでの指定も出来るようにしたい
# 
     if hs.class == Array
       # テストしてないコード、　
       mi = Hash.new
       mi[:type]  = hs.shift
       mi[:start] = hs.shift 
       mi[:limit] = hs.shift
       mi[:add]   = hs.shift
       hs         = mi.clone
     end
=end

#--------------------------------------------------
#
# Yukarin.count_limit_create
# sita ato ni .extend   site tukau
#
# なんか動かないかも   ///　色々と動かない事多いので使用は様子見
#--------------------------------------------------
=begin
module Yukarin_plus
  def self
    call
  end
  def to_s
    call
  end
  def / n
    call / n
  end
  def * n
    call * n
  end
  def + n
    call + n
  end
  def - n
    call - n
  end
  def ** n
    call ** n
  end

end
# ---------------------
#
#
=end



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
  end
    
end

=begin
a = Yakumo_chen.count_true 5
10.times do |i|
  print i , "   "
  p a.call
end

=end






