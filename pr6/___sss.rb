module Suika
  def method_missing( name , *arg )
    if arg.size == 0
      str =  <<TEXT
      def #{name}
        @#{name}
      end
      @#{name}
TEXT
    elsif name.to_s.include? "="
      str =  <<TEXT
      def #{name} miyu
        @#{name} miyu
      end
      self.#{name} arg[0]
TEXT
    else
      p __method__ , str , name , arg , caller
      exit
    end
#    puts str
    instance_eval str
  end
end


class A < Hash
  include Suika
  def q n , b
    # caller使えば完全ユニークだけど、念のためやめとく
#    c = caller.to_s + n.to_s
    c = n.to_s
    if self[ c ]
      p :err
      p caller
    end
    self[ c ] = b
    eval"self.#{n} = b"
  end
end
a = A.new
#a.extend Suika

a.q  :c , 4 
p a.c
p a.c
a.q :c , 6
p a.c

exit

a << 54
p a

