
class C
  def foo
    puts "C#foo"
  end
end

module M
  def self.a
    refine C do
      def foo
        puts "C#foo in M"
      end

x = C.new
x.foo # => "C#foo in M"
    end
  end
end

x = C.new
x.foo # => "C#foo"

M.a


x = C.new
x.foo # => "C#foo"


#using M

exit

class Q
  def initialize
    p 1
    initx rescue p $!
    initialize_module rescue p $!
  end

end

Q.include Module.new{
    attr_accessor :Flandoll , :Scarlet
    def initialize_module
      p 2
      @Flandoll = []
      @Scarlet  = Hash.new
    end
}
p Q.new.Flandoll
