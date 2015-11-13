
def Fixnum_v n
  return n if n.class == Fixnum
  p :err
end
def String_v n
  return n if n.class == String
  p :err
end
def func n
  n * 2
end

x = 10
p func Fixnum_v x
x = "abc"
p func String_v x
# p func Fixnum_v x


module Fixnum_check
  def self.extended mod
    mod * 2
  end
  def self.extend_object obj
    Fixnum_v obj
  end
end

str = "20"
p str.extend Fixnum_check

#func Fixnum_v x # err

class Uyclass
  def initialize n
    Fixnum_v n
  end
  def __function
  n * 2
  end
end

exit

def func a:
  a * 2
end

x = 2
p Fixnum a: x #=> true
puts( func Fixnum a: x ) # => 4

x = "a"
puts( func String a: x ) # => aa

p func Fixnum a: x #=> 例外
