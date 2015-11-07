# -*- encoding: UTF-8 -*-
# require "__tewi/req"  if $0 ==__FILE__



# -----------------------------------------------------
#
# TODO
#
# graph_ex ... Array 指定
#
# ({ :hash => [ 0 , 1 , 2 ] })
#
# graph_ex_ex  ... Arary  &  wait 指定
# ({ :hash => [ 0 => 10 , 1 => 6 , 2 => 4 ]
#
# -----------------------------------------------------



module Yakumo_chen
  class Count
    attr_accessor :n
    attr_accessor :true  , :false
    attr_accessor :type
    attr_accessor :true_tmp  #  graph で使う
    attr_accessor :false_tmp # link  と　 graph　で使う
    attr_accessor :start_init # start を指定する # 未実装
    attr_accessor :start_init_key # start   hash key を指定する  ___  link   graph　
    attr_accessor :c  # 数値カウントする変数
    def initialize  hs
      @c     = 0
      @n     = hs[:n]     || 1
      @true  = hs[:true]  || true
#      @false = hs[:false] || false
      # false と nil の 区別（ 一応 ）
      if hs[:false] == false
        @false = false
      else
        @false = hs[:false]
      end

      @type  = hs[:type]

      @start_init = hs[:start_init]

      @start_init_key = hs[:start_init_key]
      @false_tmp  = @start_init_key

      case @type
      when :default
        @func =->{ f_default }
      when :next
        if @true.class != Array
          @true = [ @true ]
        end
        if @false.class != Array
          @false = [ @false ]
        end

        @func =->{ f_next }
      when :link
        if @true.class == Array and @false.class == Hash
          @func =->{ f_link }
        else
          p "err"
          p __method__
        end
      when :graph
        if @true.class == Hash and @false.class == Hash
          @func =->{ f_graph }
        else
          p "err"
          p __method__
        end
      else
        p "err"
        p __method__
      end



    end
    def call
      @func.call
    end

    # ------------------------------------------------
    #
    # f_graph
    #
    # 双方向
    #
    #
    # ------------------------------------------------

    def f_graph
      @c += 1
      if @c == @n
        @c = 0
        return @false_tmp = @true[ @true_tmp ]
      end
      @true_tmp = @false[ @false_tmp ]
    end

    # ------------------------------------------------
    #
    #  f_link
    #
    # 配列 true の戻り値からfalseのハッシュを探す
    #
    # ------------------------------------------------

    def f_link

      @c += 1
      if @c == @n
        @c = 0
        ret = @true.first
        @true.rotate!
        @false_tmp = ret
        return ret
      end
      @false[ @false_tmp ]
    end

    # ------------------------------------------------
    # f_next
    #
    # true or array
    #
    # false or array
    #
    # ------------------------------------------------

    def f_next
      @c += 1
      if @c == @n
        @c = 0
        ret = @true.first
        @true.rotate!
        return ret
      end
      ret = @false.first
      @false.rotate!
      ret
    end


    # ------------------------------------------------
    #
    # default
    #
    #  true   or  false
    #
    #
    # ------------------------------------------------

    def f_default
      @c += 1
      if @c == @n
        @c = 0
        return @true
      end
      return @false
    end # d

    def copy_new
      self.class.new @n
    end

  end

  class << self
    def count_true n
      hs = Hash.new
      hs[:type] = :default
      hs[:n]    = n
      Count.new hs
    end

    def siki hs
      Count.new hs
    end

  end

end




#
#
# module Yukarin
#  の強化version
#
#





module Yakumo_ran
  class Count_limit
    attr_accessor :start , :limit , :add
    attr_accessor :add_plus
    attr_accessor :start_init
    attr_accessor :type
    attr_accessor :loopwait # 内部の変数
    attr_accessor :loopwait_wait # wait指定
    #
    # [ 100, 200 ] 配列 または wait指定ハッシュ({ 100 => 10 , 200 => 40 })
    attr_accessor :loopwait_ex
    #
    # ex（ 配列 ） のときには必ず指定　　ハッシュのときは指定しなくてもいい
    attr_accessor :loopwait_ex_wait
    attr_accessor :c
    attr_accessor :hs
    attr_accessor :msg #  mijissou
    def initialize hs = Hash.new
      @hs               = hs
      @start            = hs[:start] || 0
      @limit            = hs[:limit] || 0
      @add              = hs[:add]   || 1
      @add_plus         = hs[:add_plus] || 0
      @loopwait         = 0
      @loopwait_wait    = hs[:loopwait] || 0
      @loopwait_ex      = hs[:loopwait_ex] || []
      @loopwait_ex_wait = hs[:loopwait_ex_wait] || 0
      @type             = hs[:type] || nil
      @msg              = []
      @c = hs[:start_init] || @start

      case @type
      when :loop_rev
        if @add < 0
           @start , @limit = @limit , @start
        end
        @func =->{ count_loop_rev }
      when :loop
        @func =->{ count_loop }
      when :count_limit
        @func =->{ count_limit }
      else
        p :err
        exit
      end
    end

    #
    # dup clone だと上手くコピーされないので
    #
    def copy_new hs = @hs
      self.class.new hs
    end

    def call
      @func.call
    end


    def loop_wait_func
      if @loopwait_ex.include? @c
        if @loopwait_ex.class == Hash
          @loopwait = @loopwait_ex[ @c ]
        else
          @loopwait = @loopwait_ex_wait
        end
      end
    end

    # 0...1...2...3...4...5...6
    def count_limit

      if @loopwait > 1
        @loopwait -= 1
        return @c
      end

      @c += @add

      @add += @add_plus

      if @add > 0
        @c = @limit if @c >= @limit
      else
        @c = @limit if @c <= @limit
      end

      if (@c >= @limit) or (@c <= @start)
         @loopwait = @loopwait_wait
      end

      loop_wait_func
#      if @loopwait_ex.include? @c
#        if @loopwait_ex.class == Hash
#          @loopwait = @loopwait_ex[ @c ]
#        else
#          @loopwait = @loopwait_ex_wait
#        end
#      end

      return @c
    end

    # 0...1...2...3...4...0....wait0...wait0...1...2...3...4...wait0...wait0
    def count_loop
      if @loopwait > 1
        @loopwait -= 1
        return @c
      end
      @c += @add
      @add += @add_plus

      if @add < 0
        @c = @start if @c <= @limit
      else
        @c = @start if @c >= @limit
      end
      #if @c >= @limit
      #  @c = @start
      #end

      if (@c >= @limit) or (@c <= @start)
         @loopwait = @loopwait_wait
      end
      loop_wait_func
#      if @loopwait_ex.include? @c
#        @loopwait = @loopwait_ex_wait
#      end
      return @c
    end

    # 0...1...2...3...4...wait4...wait4...wait4...3...2...1...wait0...wait0
    def count_loop_rev
      if @loopwait > 1
        @loopwait -= 1
        return @c
      end
      @c += @add
      @add += @add_plus
      @add *= -1 if @c >= @limit || @c <= @start
      @c = @limit if @c >= @limit
      @c = @start if @c <= @start
      if (@c >= @limit) or (@c <= @start)
         @loopwait = @loopwait_wait
      end
      loop_wait_func
#      if @loopwait_ex.include? @c
#        @loopwait = @loopwait_ex_wait
#      end
      return @c
    end
  end

  class << self
    #
    # 配列をハッシュへ
    #
    def __hs_ar hs
      if hs.class == Array
        au = hs.clone
        hs = Hash.new
        hs[:start] = au[0]
        hs[:limit] = au[1]
        hs[:add]   = au[2]
      end
      return hs
    end
    def loop_rev_create hs = Hash.new
      hs = __hs_ar hs
      Count_limit.new({ type: :loop_rev, }.merge( hs ))
    end
    def loop_create     hs = Hash.new
      hs = __hs_ar hs
      Count_limit.new({ type: :loop, }.merge( hs ))
    end
    def count_limit_create  hs = Hash.new
      hs = __hs_ar hs
      Count_limit.new({ type: :count_limit, }.merge( hs ))
    end

#
# mi method name
#
    def cc *h
      return count_limit_create  h.first  if h.first.class == Hash
      count_limit_create  h
    end
    def lo *h
      return loop_create  h.first  if h.first.class == Hash
      loop_create  h
    end
    def lr *h
      return loop_rev_create  h.first  if h.first.class == Hash
      loop_rev_create  h
    end

    def siki  hs
      Count_limit.new hs
    end

# 念のため
#     alias count_loop_create      loop_create
#     alias count_loop_rev_create  loop_rev_create
#

# Yukarin とあわせる

#    alias cc  count_limit_create
#    alias lo  loop_create
#    alias lr  loop_rev_create


  end
end



class Yakumo_yukari < Enumerator
  attr_accessor :enum
  attr_accessor :cc

  attr_accessor :mod , :hs

  def initialize  mod , hs = Hash.new
    @mod = mod # misiyou
    @hs  = hs  # misiyou

    y = -> e do
      @cc = mod.method(:siki).call hs
      loop do
        e.yield @cc.call
      end
    end
    @enum = super &y
  end

# Yakumo_ran とか呼び出すのややこしすぎ、どうしよ
#  def copy_new hs = @hs # , mod  = @mod
#    self.class.new  @mod , @hs
#  end


  def call
    self.next
  end
  class << self
    def ran_f hs
      if hs.first.class == Hash
        hs = hs.first
      else
        au = hs.clone
        hs = Hash.new
        hs[:start] = au[0]
        hs[:limit] = au[1]
        hs[:add]   = au[2]
#        hs[:start_init] =  au[3]
      end
      return hs
    end

    [
      :count_limit , :cc ,
      :loop        , :lo ,
      :loop_rev    , :lr ,
      ]
    .each_slice 2 do |  type , name  |
      define_method name  do | *hs |
        hs =  ran_f  hs
        hs[:type] = type
        Yakumo_yukari.new  Yakumo_ran , hs
      end
    end # e

    def chen_f hs
      if hs.first.class == Hash
        hs = hs.first
      else
        au = hs.clone
        hs = Hash.new
        hs[:n]     = au[0]
        hs[:true]  = au[1]
        hs[:false] = au[2]
      end
      hs
    end

    [
      :default , :ch       ,
      :next    , :ch_next  ,
      :link    , :ch_link  ,
      :graph   , :ch_graph ,
      ]
    .each_slice 2 do |  type , name  |
      define_method name  do | *hs |
        hs =  chen_f  hs
        hs[:type] = type
        Yakumo_yukari.new  Yakumo_chen , hs
      end
    end # e

  end # c
end








__END__



p Yakumo_yukari.ch( 3 ).take(10)
p Yakumo_yukari.ch( 3 , "a" , "b" ).take(10)
p Yakumo_yukari.ch_next( 4 , [1,2,3] , ["a","b"] ).take(10)
p Yakumo_yukari.ch_next( 4 , "z" , ["a","b"] ).take(10)

p Yakumo_yukari.ch_link( 4 , [1,2,3] , { 1 => "a" , 2 => "b" , 3 => "c" } ).take(10)

y = Yakumo_yukari.ch_link({
 :n     => 3 ,
 :true  => [1 ,2 ,3] ,
 :false => ({ :start => "__", 1 => "a" , 2 => "b" , 3 => "c"  }) ,
 :start_init_key => :start ,
})
p y.take(20)

y = Yakumo_yukari.ch_graph({
 :n     => 4 ,
 :true  => ({ "__"  => 1 , "a" => 2 , "b" => 3 }) ,
 :false => ({ :start => "__", 1 => "a" , 2 => "b" , 3 => "__"  }) ,
 :start_init_key => :start ,
})
p y.take(20)



exit

y = Yakumo_yukari.ch_next 5 , ["a","b"] , [1,2,3]
p y.call
p y.call
p y.next



p Yakumo_yukari.ch(4,"a","b").take(10)
#p Yakumo_yukari.ch_next(3,[*1..100],[*"a".."z"]).take(100)





__END__


puts
puts "-"*60
puts
puts "--- Yakumo_chen ---"
puts
puts "-"*60
puts



puts "--- ch_graph ---"
ss = Hash.new
ss.default_proc =->a,b{ a[b] = "chen" }
tt = Hash.new
tt.default_proc =->a,b{ a[b] = :start }
y = Yakumo_yukari.ch_graph({
 :n     => 4 ,
 :true  => tt.merge({ "yk"  => 10 , "a" => 20 , "b" => 30 }) ,
 :false => ss.merge({ :start => "yk", 10 => "a" , 20 => "b" }) ,
 :start_init_key => :start ,
})

p y.take(24)



puts "--- ch_next ---"
y = Yakumo_yukari.ch_next 5 , ["a","b"] , [1,2,3]
p y.take(24)


puts "--- ch_next ---"
y = Yakumo_yukari.ch_next 5 , "z" , [1,2,3]
p y.take(24)


puts "--- ch_link ---"
ss = Hash.new
ss.default_proc =->a,b{
  a[b] = "chen"
}
y = Yakumo_yukari.ch_link({
 :n     => 4 ,
 :true  => [10 ,20 ,30] ,
 :false => ss.merge({ :start => "yk", 10 => "a" , 20 => "b" }) ,
 :start_init_key => :start ,
})
p y.take(16)




puts "--- ch_next ---"
y = Yakumo_yukari.ch_next 5 , ["a","b"] , [1,2,3]
p y.take(24)

puts "--- ch_ ---"
y = Yakumo_yukari.ch 5 , 1 , nil
p y.take(10)

puts "--- ch_ ---"
y = Yakumo_yukari.ch 5 , true , false
p y.take(10)

puts "--- ch_ ---"
y = Yakumo_yukari.ch 5
p y.take(10)



puts "-"*40
puts
puts " "*15 + "Yakumo_ran"
puts
puts "-"*40


puts "---- Yakumo_yukari.lr_ex ----"
y = Yakumo_yukari.lr ({
start: 0 ,
limit: 10 ,
add: 1 ,
#start_init: 2 ,
#loopwait: 3 ,
#loopwait_ex_wait: 3,
loopwait_ex: ({ 4 => 2 , 6 => 4 }) ,
#add_plus: 1 ,
})
p y.take(20)


puts "---- Yakumo_yukari.cc ----"
y = Yakumo_yukari.cc(1,10,1)
p y.take(20)

puts "---- Yakumo_yukari.lo ----"
y = Yakumo_yukari.lo(1,5,1)
p y.take(20)

puts "---- Yakumo_yukari.lr ----"
y = Yakumo_yukari.lr(1,10,1)
p y.take(20)



puts "--- old output ---"
puts "-"*60
puts
puts " --Yakumo_ran   direct  --"
puts
puts "-"*60
puts
puts

a = Yakumo_ran.loop_rev_create({
start: 0 ,
#start_init: 2 ,
limit: 10 ,
add: 1 ,
#loopwait: 3 ,
#loopwait_ex_wait: 3,
loopwait_ex: ({ 5 => 2 , 7 => 4 }) ,
#add_plus: 1 ,
})

puts "----loop_rev loopwait_ex----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts




a = Yakumo_ran.loop_rev_create({
start: 0 ,
#start_init: 2 ,
limit: 15 ,
add: 1 ,
#loopwait: 3 ,
loopwait_ex_wait: 3,
loopwait_ex: [5] ,
#add_plus: 1 ,
})

puts "----loop_rev plus----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts

a = Yakumo_ran.loop_rev_create({
start: 15 ,
#start_init: 2 ,
limit: 0 ,
add: -1 ,
#loopwait: 3 ,
loopwait_ex_wait: 3,
loopwait_ex: [5] ,
#add_plus: 1 ,
})

puts "----loop_rev minus----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts





a = Yakumo_ran.loop_create({
#type: :loop,
start: 0 ,
#start_init: 2 ,
limit: 6 ,
add: 1 ,
#loopwait: 2 ,
#loopwait_ex_wait: 2,
#loopwait_ex: [3,4] ,
#add_plus: 1 ,
})



puts "----loop plus----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts




a = Yakumo_ran.loop_create({
#type: :loop,
start: 6 ,
#start_init: 2 ,
limit: 0 ,
add: -1 ,
#loopwait: 2 ,
#loopwait_ex_wait: 2,
#loopwait_ex: [3,4] ,
#add_plus: 1 ,
})


puts "----loop minus----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts



a = Yakumo_ran.loop_rev_create({
start: 0 ,
#start_init: 2 ,
limit: 5 ,
add: 1 ,
loopwait: 3 ,
#loopwait_ex_wait: 3,
#loopwait_ex: [5] ,
#add_plus: 1 ,
})

puts "----loop_rev loopwait----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts




a = Yakumo_ran.loop_rev_create({
start: 0 ,
#start_init: 2 ,
limit: 5 ,
add: 1 ,
#loopwait: 3 ,
loopwait_ex_wait: 3,
loopwait_ex: [1,3,5] ,
#add_plus: 1 ,
})

puts "----loop_rev loopwait_ex----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts




a = Yakumo_ran.count_limit_create({
start: 0 ,
#start_init: 2 ,
limit: 15 ,
add: 1 ,
#loopwait: 3 ,
loopwait_ex_wait: 3,
loopwait_ex: [5] ,
#add_plus: 1 ,
})

puts "----counut_limit plus----"
25.times do |i|
  printf "%3d  " % [ a.call ]
end
puts






=begin
    def cc *hs
      hs =  sub_f  hs
      hs[:type] = :count_limit
      Yakumo_yukari_sama.new hs
    end
    def lo *hs
      hs =  sub_f  hs
      hs[:type] = :loop
      Yakumo_yukari_sama.new hs
    end
    def lr *hs
      hs =  sub_f  hs
      hs[:type] = :loop_rev
      Yakumo_yukari_sama.new  hs
    end
=end




=begin

    def ch *hs
      hs =  chen_f  hs
      hs[:type] = :default
      Yakumo_yukari.new  Yakumo_chen , hs
    end

    def ch_next *hs
      hs =  chen_f  hs
      hs[:type] = :next
      Yakumo_yukari.new  Yakumo_chen , hs
    end

# false _ link
# true _ link
    def ch_link *hs
      hs =  chen_f  hs
      hs[:type] = :link
      Yakumo_yukari.new  Yakumo_chen , hs
    end

    def ch_graph *hs
      hs =  chen_f  hs
      hs[:type] = :graph
      Yakumo_yukari.new  Yakumo_chen , hs
    end
=end
