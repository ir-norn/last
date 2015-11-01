class Q
  attr_accessor :x
  def r
new
  end
 class << self
   def f
#     self.instance_eval do
     p new
#   end
   end end

end
Q.f.x
Q.f.r


exit
module Q
  module S
  end
  refine Fixnum do

  end

end

module RefineModule
end

def func
  RefineModule.module_eval do
    refine Fixnum do
      def f
        p 3
      end
    end
  end
  Module.new.module_eval   do
    using RefineModule
    1.f
  end
end
func
exit
#
# require 'forwardable'
#
# module Enumerable
#   def dmap
#     p self.class
#     DelegateMap.new self
#   end
#   class DelegateMap
#     extend Forwardable
#     def initialize base
#       @base = base
#     end
#     def method_missing f , *args , &proc
#       p f
#       @base.map { |m| m.send(f, *args, &proc) }
#     end
#   end
#
# end
#
# p [1,2,3].dmap + 6
#

require 'forwardable'

class Foo
  extend Forwardable

  def_delegators("@out", "printf", "print")
  def_delegators(:@in, :gets)
  def_delegator(:@contents, :[], "content_at")
end
f = Foo.new
f.printf "ssss"


exit

require 'forwardable'

class MyQueue
  extend Forwardable
  def initialize
    @queue = []
  end
  def_delegators :@queue , :push, :<<, :shift,
  :first, :last ,:size , :clear, :to_a
end

q = MyQueue.new
q.push 1 , 2
q << 5
p q # => #<MyQueue:0x38356f0 @queue=[1, 2, 5]>
p q.shift # => 1
p q.pop rescue p $!




exit

require "Forwardable"
class Foo
  extend Forwardable

  def f n
    n + n
  end
  # def_delegators("@out", "printf", "print")
  def_delegators("@f", "puts")
  def_delegators(:@in, :gets)
  def_delegator(:@contents, :[], "content_at")
end
f = Foo.new
f.puts 1 , 2
# f.gets
#f.content_at(1)



exit

require 'singleton'
class SomeSingletonClass
  include Singleton
  def initialize
    p 2
  end

end
a = SomeSingletonClass.instance
b = SomeSingletonClass.instance  # a and b are same object
p [a,b]
a = SomeSingletonClass.new               # error (`new' is private)
