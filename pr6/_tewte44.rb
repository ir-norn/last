class Demo
  def self.cleanup
    lambda {puts "finalized!"}
  end

  def initialize
    @a = "abcdefg" * 1024 * 1024 * 2
    ObjectSpace.define_finalizer(self, self.class.cleanup)
  end
end

1.upto 8 do |i|
  puts Time.now
  Demo.new
end


exit

def func
  file = nil , line = nil
  caller().each do |str|
    str =~ /(.*?):(\d+)/
    file, line = $1, $2
  end
  5.instance_exec do
    p to_s # => 5
    eval open(file).each_line.to_a[line.to_i-1].sub( __method__.to_s, "1.times") # => 5
  end
end

# func do p to_s end

1.times do
  o = Object.new # 調べたいやつ
  ObjectSpace.define_finalizer(o , ->{ p 2322 })
end

exit
ObjectSpace
ObjectSpace.trace_object_allocations_start

o = Object.new # 調べたいやつ
ObjectSpace.trace_object_allocations_stop
p ObjectSpace.allocation_class_path
p ObjectSpace.allocation_generation
p ObjectSpace.allocation_method_id
p ObjectSpace.allocation_sourcefile
p ObjectSpace.allocation_sourceline
p ObjectSpace.allocation_sourcefile
p ObjectSpace.allocation_sourceline
ObjectSpace.trace_object_allocations_clear
