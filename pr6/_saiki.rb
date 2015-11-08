
case true

when 1
p 2
next

when 2

end


exit
class A
  def a
    @x=3
    func @x
    p @x
  end
end
def func x
  x = 9
end

A.new.a



exit

require "Benchmark"


o = Fiber.new do
  10000000.times do
     x = Fiber.yield
  end
end ; o.resume


o.resume 6

e = Enumerator.new do |y|
  10000000.times do
     x = y.yield
  end
end ; e.next

e.feed "xx"
e.next


N = 100000
Benchmark.bm do |q|
  q.report(:a) {
    N.times { o.resume }   }
  q.report(:b) {
    N.times {
    e.next }   }
end

exit

p "xxx" << "34"
exit


RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

RubyVM::InstructionSequence.compile(<<EOS).eval

def f(n, acc = 1 , b = [])
  return acc if n == 0
  b = [1,2,3]
  x = 2
  case false
  when true then nil
  else
    x = 1
  end
    f(n - 1, acc * n , b)
end
# f = ->(n, acc = 1 , b = []) do
#   if n == 0
#     acc
#   else
#   b = [1,2,3]
#     f.call(n - 1, acc * n , b)
#   end
# end
f 20000

EOS
