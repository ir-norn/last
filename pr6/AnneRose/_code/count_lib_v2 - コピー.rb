

require_relative "./chino_to_enum"

module Count_lib_v2_m
  attr_reader :enum , :count , :start , :limit , :add
  def initialize start: , limit: , add:
    @start = start ; @limit = limit ; @add = add
    @enum  = @start.step(@limit,@add)
    @argv  = [@start , @limit , @add]
    rewind
  end
  def fiber_yield      # ovar lide
    @fib = Fiber.new do
      fiber_yield_sub
      Fiber.yield limit while true
    end # f
  end
  def fiber_yield_sub
    enum.each_with_index do | m , i |
      @count = i
      Fiber.yield m
    end
  end
  def rewind
    @count = 0
    @peek  = 0
    fiber_yield
  end # df
  # Enumerableのpeekはnextを示すけど
  # このクラスの prev_peek は一つ前のnextの結果をメモしてるので
  # 1個ズレてる
  def peek ; @peek ; end
  def prev_peek ; @peek ; end
  def next
    @peek = @fib.resume
  end
  def prev
    count_tmp = @count
    rewind
    count_tmp.times do self.next end
    @peek
  end
  def take n
    n.times.map do self.next end
  end
end
class Count_lib_v2
  include Count_lib_v2_m
end
class Count_lib_v2_rev
  include Count_lib_v2_m
  undef_method  :prev  # muzui mi ji ssou
  def fiber_yield
    @fib = Fiber.new do | x |
      fiber_yield_sub
      limit.-(1).step(start+1,-add).each.with_index @count do | m , i |
        @count = i
        Fiber.yield m
      end
      rewind
      @fib.resume
    end # f
  end # d
end
class Count_lib_v2_cycle
  include Count_lib_v2_m
  undef_method  :prev  # muzui mi ji ssou
  def fiber_yield
    @fib = Fiber.new do | x |
      fiber_yield_sub
      rewind
      @fib.resume
    end # f
  end # d
end


__END__

ch = Count_lib_v2.new( start: 0 , limit: 3 , add: 1 )
p "-Count_lib_v2-"
print"next:"; 5.times { print ch.next , " " } ; puts
print"prev:"; 5.times { print ch.prev , " " } ; puts
ch.rewind
print"next:"; 5.times { print ch.next , " " } ; puts
print"peek:"; 5.times { print ch.prev_peek , " " } ; puts

ch = Count_lib_v2_rev.new( start: 0 , limit: 3 , add: 1 )
p "-Count_lib_v2_rev-"
12.times { print ch.next , " " } ; puts
#12.times { print ch.prev , " " } ; puts
ch.rewind
12.times { print ch.next , " " } ; puts

ch = Count_lib_v2_cycle.new( start: 0 , limit: 3 , add: 1 )
p "-Count_lib_v2_cycle-"
12.times { print ch.next , " " } ; puts
#12.times { print ch.prev , " " } ; puts
ch.rewind
12.times { print ch.next , " " } ; puts

p "-Count_lib_v2_cycle loop_wait -"
ch.rewind
12.times { |i|
  if (3..5).include? i
    print ch.prev_peek , " " ; next
  end
  print ch.next , " "
} ; puts
p ch.take(15)


# --------------------------

if false
class Count_limit
  def initialize start: 0, add: 1, limit: 5
p add
exit
  end
end

Fiber.new do
end

a = Count_limit.new({
start:0 ,
add: 1,
limit: 5 ,
})
7.times do
  p a.next
end
end # if f
