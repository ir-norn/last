if false
fib = Enumerator.new do |y|
  a = b = 1
  99.times do
    y.yield a
    a, b = b, a + b
  end
end


4.times do p fib.next end
p fib.rewind
4.times do p fib.next end

fib = Fiber.new do
  5.times do |i|
    Fiber.yield i
  end
end # f
4.times do p fib.resume end
p fib.rewind
4.times do p fib.resume end

exit
class Group < Enumerator
#  include Enumerable
  def initialize _
    super  # [] , &:each
    @count = 0
  end
  def initializexxxx start: , limit: , add:
#    super
p    instance_variables
    @start = start ; @limit = limit ; @add = add
    @enum  = @start.step(@limit,@add)
    @argv  = [start , limit , add]
    @members = [2,3,4]
#    rewind
  end
  # def my_each
  #   self.each do |person|
  #     yield person
  #   end
  # end
  def next
    super
    @count += 1
  end
  def prev
    tmp_count = @count - 1
    nil
  end
end

#ch = Group.new( start: 0 , limit: 3 , add: 1 )
ch = Group.new(
#[5,6,7]
0.step(3,1).to_enum
).to_enum
#ch.to_enum
p ch.next
p ch.peek
p ch.rewind
p ch.next
p ch.next
p ch.next
p ch.prev
p ch.prev
p ch.prev
exit
#ch.my_each do|m| p m end
# ch.each do|m|
#   p m
# end

exit

end

module Count_lib_v2_m
  attr_reader :enum , :count , :start , :limit , :add
  def initialize start: , limit: , add:
    @start = start ; @limit = limit ; @add = add
    @enum  = @start.step(@limit,@add)
    @argv  = [start , limit , add]
    rewind
  end
  def fiber_yield
    @fib = Fiber.new do
      start.step(limit,add) do | m |
        Fiber.yield m
        @count += 1
      end
      fiber_end
    end # f
  end
  def fiber_end
    loop do  Fiber.yield limit end
  end
  def rewind
    @count = 0
    @tmp   = 0
    fiber_yield
  end # df
  def peek
    @tmp
  end
  def next
    @tmp = @fib.resume
  end
  def prev
    count_tmp = @count - 1
    rewind
    @fib.resume
    count_tmp.times do self.next end
    self.peek
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
      start.step(limit,add) do | m |
        Fiber.yield m
        @count += 1
      end
      limit.-(1).step(start+1,-add) do | m |
        Fiber.yield m
        @count += 1
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
      start.step(limit,add) do | m |
        Fiber.yield m
        @count += 1
      end
      rewind
      @fib.resume
    end # f
  end # d
end


ch = Count_lib_v2.new( start: 0 , limit: 3 , add: 1 )
# p 0.step(5,1).cycle.take(20)
# p ch = [ch.next,ch.next,ch.next,ch.next,ch.prev,ch.prev].cycle
# 20.times { print ch.next , " " } ; puts
#
# exit ----------

p "-Count_lib_v2-"
5.times { print ch.next , " " } ; puts
5.times { print ch.prev , " " } ; puts
ch.rewind
5.times { print ch.next , " " } ; puts

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

ch.rewind
12.times { |i|
  if (3..5).include? i
    print ch.peek , " " ; next
  end
  print ch.next , " "
} ; puts
p ch.take(15)






#
# x = 0.step(10,1)
# p x
# p x.next
# p x.next
# p x.next
# p x.peek
# p x.rewind
# p x.next
# p x.next




__END__
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
