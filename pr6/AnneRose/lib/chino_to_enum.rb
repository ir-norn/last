
class Focus
  attr_reader :focus , :size
  def initialize size
    @focus = 0
    @size  = size
  end
  def rewind
    @focus = 0
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


class Focus_Array
  attr_reader :focus , :ar
  def initialize ar
    @ar = ar
    @focus = 0
  end
  def size
    ar.size
  end
  def rewind
    @focus = 0
  end
  def seek
    ar[ focus ]
  end
  def peek
    ar[ (focus+1) % ar.size ]
  end
  def next
    ar[ @focus = (focus+1) % ar.size ]
  end
  def prev
    ar[ @focus = (focus-1) % ar.size ]
  end
end






module Enumerable
  def chino_to_enum
    enum = Enumerator.new do |y|
      each_with_index do |m,i|
        y.yield enum._state = m
        enum._prev_count = i
      end
    end
    enum.extend Module.new{ attr_accessor :_prev_count , :_state }
    enum._prev_count = 0
    enum
  end
  def seek
    _state
  end
  def prev
    rewind
    _prev_count.times do self.next end
    peek
  end
  def cycle_rev
    (self.to_a + self.to_a.reverse[1...-1]).cycle
  end
  def cocoa_to_enum
    enum = chino_to_enum
    def enum.next ; super
    rescue StopIteration
      _state
    end
    return enum
  end
end

#__END__


# p x = 0.step(2,1).cycle_rev
# p x = 0.step(2,1)
N = 5

ch = Focus_Array.new 0.step(N,1).to_a
#ch = 0.step(N,1).chino_to_enum
p "-chino_to_enum-"
print"next:"; N.times { print ch.next , " " } ; puts
print"prev:"; N.times { print ch.prev , " " } ; puts
ch.rewind
print"next:"; N.-(1).times { print ch.next , " " } ; puts
print"peek:"; N.times { print ch.peek , " " } ; puts

NN = 12
ch = 0.step(N,1).cocoa_to_enum
p "-cocoa_to_enum-"
print"next:"; NN.times { print ch.next , " " } ; puts
print"prev:"; NN.times { print ch.prev , " " } ; puts
ch.rewind
print"next:"; N.-(1).times { print ch.next , " " } ; puts
print"peek:"; NN.times { print ch.peek , " " } ; puts


ch = 0.step(4,1).cycle_rev.chino_to_enum
p "-cycle_rev-"
print"next:"; NN.times { print ch.next , " " } ; puts
print"prev:"; NN.times { print ch.prev , " " } ; puts
ch.rewind
print"next:"; NN.times { print ch.next , " " } ; puts
print"peek:"; NN.times { print ch.peek , " " } ; puts


# "-chino_to_enum-"
# next:0 1 2 3 4
# prev:3 2 1 0 0
# next:0 1 2 3
# peek:4 4 4 4 4
# "-cocoa_to_enum-"
# next:0 1 2 3 4 5 5 5 5 5 5 5
# prev:5 4 3 2 1 0 0 0 0 0 0 0
# next:0 1 2 3
# peek:4 4 4 4 4 4 4 4 4 4 4 4
# "-cycle_rev-"
# next:0 1 2 3 4 3 2 1 0 1 2 3
# prev:2 1 0 1 2 3 4 3 2 1 0 0
# next:0 1 2 3 4 3 2 1 0 1 2 3
# peek:4 4 4 4 4 4 4 4 4 4 4 4


exit


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
