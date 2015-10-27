
class Tree_task
  attr_accessor :func ,:task ,:sym ,:n ,:up
  def initialize hs = Hash.new , &block
    @func = block
    @task = Hash.new
    @sym  = hs[:sym] || :nil
    @up   = hs[:up]
  end
  def __taskloop
    task.map do | key , v | task[key].func = v.func[v].func end
  end
  def Main sym , &block
    Task sym , &block
    nil while not __taskloop.empty?
  end
  def Task sym = :task , hs = Hash.new , &block
    task.store sym , self.class.new(hs.merge( up:self , sym:sym ) , &block)
  end
  def Code
    self.class.new do
      yield
      __taskloop
      self
    end
  end
end

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
          if y == 0
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
