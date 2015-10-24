# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__


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

__END__

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



__END__

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


