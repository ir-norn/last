
module Enumerable
  def chino_to_enum
    fib = Enumerator.new do |y|
      each_with_index do |m,i|
        y.yield m
        fib._prev_count = i
      end
    end
    fib.extend Module.new{ attr_accessor :_prev_count }
    fib
  end
  def prev
    rewind
    _prev_count.times do self.next end
    peek
  end

end

ch = 0.step(5,1).chino_to_enum

p "-Count_lib_v2-"
print"next:"; 5.times { print ch.next , " " } ; puts
print"prev:"; 5.times { print ch.prev , " " } ; puts
ch.rewind
print"next:"; 5.times { print ch.next , " " } ; puts
print"peek:"; 5.times { print ch.peek , " " } ; puts


require "Benchmark"
Benchmark.bm do|x| N = 1000
  enum = 0.step(10000,1)
  ch = enum.chino_to_enum
  x.report :next do  N.times do ch.next end end
  x.report :peek do  N.times do ch.peek end end
  x.report :prev do  N.times do ch.prev end end
end

exit

fib = Group.new [1,2,3]
p fib.my_each
p fib.map
#p fib.take(10) # => [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

#e = Enumerator.new(ObjectSpace, :each_object)
#  warning: Enumerator.new without a block is deprecated; use Object#to_enum



fib = Enumerator.new do |y|
  fib.extend Module.new{ attr_accessor :count }
  fib.count = 0
  99.times do |i|
    y.yield i
    fib.count += 1
  end
end

4.times do p fib.next end
p fib.rewind
4.times do p fib.next end

def fib.prev
  count_tmp = @count - 1
  @count = 0
  self.rewind
  count_tmp.times do self.next end
  self.peek
end
p fib.prev
p fib.prev
p fib.prev
p fib.prev

exit


fib = Fiber.new do
  5.times do |i|
    Fiber.yield i
  end
end # f
4.times do p fib.resume end
p fib.rewind
4.times do p fib.resume end

exit
