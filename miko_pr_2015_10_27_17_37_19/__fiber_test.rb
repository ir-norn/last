
class Tree_task
  attr_accessor :func ,:task ,:sym ,:n ,:up
  def initialize hs = Hash.new , &block
    @sym      = hs[:sym]
    @up       = hs[:up]
    @func     = block
    @task     = []
# scene
    @Flandoll = []
    @Scarlet  = Hash.new
  end
  def __taskloop
    task.each_with_index do | b , i | task[i].func = b.func[b].func end
  end
  def Main sym , &block
    Task sym , &block
    nil while not __taskloop.empty?
  end
  def Task sym = :task , &block
    task << self.class.new(up:self , sym:"#{sym}_#{self.hash}".to_sym , &block)
  end
  def Code
    self.class.new do
      yield
      __taskloop
      self
    end
  end
end

a = nil
f = Fiber.new do
   loop do
     p Fiber.yield
   end
end

f.resume
f.resume(:mese)
f.resume(99)
f.resume(99)
#p f.resume(:foo)


exit


Tree_task.new.Main :top_symbol do | o |
  z = 5
  y = 3
  x = 10
  o.Code do
  print "x=", x , "_"    ;  x-=1 ; x < 0 && exit
    if x == 8
      o.Task :task do |o|
        o.Code do
          print "y=", y , "_"
          y -= 1
          if y == AA.yield
            o.Task :title do |o|
              o.Code do
                o.Main :title_main do |o|
                  p :title_main__
                  o.Code do
                    p :title_main__code
                    print "z=", z , "_" ;  z-=1 ; z < 0 && exit
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
