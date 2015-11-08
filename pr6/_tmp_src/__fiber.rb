
module Count_lib_v2_m
  attr_reader :enum , :start , :limit , :add
  def initialize start: , limit: , add:
    @start = start ; @limit = limit ; @add = add
    @enum  = @start.step(@limit,@add)
    @argv  = [start , limit , add]
    rewind
  end
  def fiber_yield
    @fib = Fiber.new do
      Fiber.yield 3
      p 3
      exit
      start.step(limit,add) do | m |
        Fiber.yield m
        @count += 1
      end
      loop do  Fiber.yield limit end
    end # f
  end
  def rewind
    @count = 0
    @tmp   = 0
    fiber_yield
    @fib.resume
  end # df

  def next
    @tmp = @fib.resume
  end

end
class Count_lib_v2
  include Count_lib_v2_m
end
ch = Count_lib_v2.new( start: 0 , limit: 3 , add: 1 )
p "-Count_lib_v2-"
9.times { print ch.next , " " } ; puts





#
