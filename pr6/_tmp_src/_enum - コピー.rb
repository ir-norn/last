class Group  < Enumerator
#  include Enumerable
#  include Enumerable
  def initialize _


#    @lookahead = _

#    super
#    super  # [] , &:each

    @count = 0
  end
  def my_each
    self
  end

#p Enumerable.methods.sort
end
module Enumerable
  def chino_to_enum_cycle
    fib = Enumerator.new do |y|
      fib._prev_count = 0
      self_last = nil
      self.each do |i|
        y.yield self_last = i
        fib._prev_count += 1
      end
      rewind
      fib.next
    end
    fib.extend Module.new{ attr_accessor :_prev_count , :_prev_flag  }
    fib
  end
  def chino_to_enum_rev
  end
  def chino_to_enum
    fib = Enumerator.new do |y|
      fib._prev_count = 0
      self_last = nil
      self.each do |i|
        y.yield self_last = i
        fib._prev_count += 1
      end
      fib._prev_flag = true
      loop do  y.yield self_last end
    end
    fib.extend Module.new{ attr_accessor :_prev_count , :_prev_flag  }
    fib
  end
  def prev
    if self._prev_flag
       self._prev_flag = false
         tmp_count = self._prev_count - 2
    else tmp_count = self._prev_count - 1  end
    rewind
    self._prev_count = 0
    tmp_count.times do self.next end
    peek
  end

end

ch = 0.step(3,1).chino_to_enum
ch = 0.step(3,1).chino_to_enum_cycle
p "-Count_lib_v2-"
print"next:"; 5.times { print ch.next , " " } ; puts
print"prev:"; 5.times { print ch.prev , " " } ; puts
ch.rewind
print"next:"; 5.times { print ch.next , " " } ; puts
print"peek:"; 5.times { print ch.peek , " " } ; puts
exit

require "Benchmark"
Benchmark.bm do|x| N = 1000
  enum = 0.step(230,1)
  ch = enum.chino_to_enum
  x.report :next do  N.times do ch.next end end
  x.report :peek do  N.times do ch.peek end end
  x.report :prev do  N.times do ch.prev end end
  ch = enum.chino_to_enum_v2
  x.report :next_v2 do  N.times do ch.next end end
  x.report :peek_v2 do  N.times do ch.peek end end
  x.report :prev_v2 do  N.times do ch.prev end end
end    if  false

exit

fib = Group.new [1,2,3]
p fib.my_each
p fib.map
#p fib.take(10) # => [1, 1, 2, 3, 5, 8, 13, 21, 34, 55]

#e = Enumerator.new(ObjectSpace, :each_object)
#  warning: Enumerator.new without a block is deprecated; use Object#to_enum
