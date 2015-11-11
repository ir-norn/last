
#require_relative "./lib/chino_to_enum"
require_relative "./Count_lib_v2"

module Enumerable
  def chino_to_enum
    fib = Enumerator.new do |y|
      each_with_index do |m,i|
        y.yield fib._state = m
        fib._prev_count = i
      end
    end
    fib.extend Module.new{ attr_accessor :_prev_count , :_state }
    _prev_count ||= 0
    fib
  end
  def seek
    _state
  end
  def prev
    rewind
    _prev_count.times do self.next end
    peek
  end

end



#__END__

# ch = 0.step(5,1).chino_to_enum
ch = 0.step(5,1).chino_to_enum

# p "-chino-"
# print"next:"; 5.times { print ch.next , " " } ; puts
# print"prev:"; 5.times { print ch.prev , " " } ; puts
# ch.rewind
# print"next:"; 5.times { print ch.next , " " } ; puts
# print"peek:"; 5.times { print ch.peek , " " } ; puts


class Array_cycle
  attr_accessor :size , :seek
  def initialize size
    @size = size
    rewind
  end
  def rewind
    @aa = [*1..size].cycle
    @bb = [*-size..-1].reverse.cycle
  end
  def seek
    @seek
  end
  def peek
    @aa.peek + @bb.peek
  end
  def next
    @seek = @aa.next
  end
  def prev
    @bb.next
  end
end

class Focus
  attr_reader :focus , :size
  def initialize focus , size
    @focus = focus
    @size  = size
  end
  def seek
    focus
  end
  def peek
    (focus+1) % size
  end
  def next
    @focus = (focus+1) % size
  end
  def prev
    @focus = (focus-1) % size
  end
end


__END__


require "Benchmark"
Benchmark.bm do|x| N = 5000
  enum = 0.step(10000,1)
  p "-chino-"
  ch = enum.chino_to_enum
  x.report :next do  N.times do ch.next end end
  x.report :peek do  N.times do ch.peek end end
  x.report :prev do  N.times do ch.prev end end
  x.report :seek do  N.times do ch.seek end end
  p "-Count_lib_v2-"
  ch = Count_lib_v2.new( start: 0 , limit: 10000 , add: 1 )
  x.report :next do  N.times do ch.next end end
  x.report :peek do  N.times do ch.peek end end
  x.report :prev do  N.times do ch.prev end end
  x.report :seek do  N.times do ch.seek end end
  p "-Array_cycle-"
  ch = Array_cycle.new 10000
  x.report :next do  N.times do ch.next end end
  x.report :peek do  N.times do ch.peek end end
  x.report :prev do  N.times do ch.prev end end
  x.report :seek do  N.times do ch.seek end end
  p "-Focus-"
  ch = Focus.new 0 , 10000
  x.report :next do  N.times do ch.next end end
  x.report :peek do  N.times do ch.peek end end
  x.report :prev do  N.times do ch.prev end end
  x.report :seek do  N.times do ch.seek end end

end
