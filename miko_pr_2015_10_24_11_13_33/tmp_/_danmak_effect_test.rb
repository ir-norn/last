require "dxruby"

def move x , y , s , a
  x += (s * Math::cos(a * Math::PI/180 ))
  y += (s * Math::sin(a * Math::PI/180 ))
  [x , y , s , a]
end
def DegToRad x
  x*Math::PI/180
end
def RadToDeg x
  x*180/Math::PI
end
def homing_angle  x , y , x2 , y2
   return RadToDeg( Math.atan2( y2 - y , x2 - x ))
end

def blockhit x1 , y1 , w1 , h1 , x2 , y2 , w2 , h2
  x1 + w1 > x2 && x1 < x2 + w2 && y1 + h1 > y2 && y1 < y2 + h2 
end
def count_limit_create  c , limit , add
  if add > 0
  # plus
    return lambda do
      c += add
      c = limit if c >= limit
      return c
    end
  else
  # minus
    return lambda do
      c += add
      c = limit if c <= limit
      return c
    end
  end
end
def count_loop_create  start , limit , add
  c = start
  start , limit = limit , start if add < 0
  lambda do
    c += add
    c = start if c >= limit
    return c
  end
end


class O 
  attr_accessor :x , :y , :d , :sym , :func
  def initialize hs = Hash.new
    @x     = hs[:x]
    @y     = hs[:y] 
    @d     = hs[:d] 
    @sym   = hs[:sym] 
    @func  = -> o do yield o end
  end
  def update
    @func.call self
  end
end

task = []
task << O.new( sym: :user , x:100, y:100 , d:Image.new(40,40,[200,100,200,150]) ) do |o|
  s = 4 
  o.x += Input.x*s 
  o.y += Input.y*s
  Window.draw o.x , o.y , o.d
  
  Input.setRepeat 10 , 4
  if Input.keyPush? K_Z
    task << O.new( sym: :user_shot , x: o.x , y: o.y ,
       d:Image.new(10,10,[200,100,170,140]) ) do |o|
      s = 5
      o.y -= s
      Window.draw o.x , o.y , o.d
      task -= [o] if o.y < -100 
    end
  end
  Input.setRepeat 0, 0

  if Input.keyPush? K_C
    100.times do |i|
      task << O.new( sym: :te , x:rand(600), y: rand(500) , d:Image.new(20,20,[200,100,120,220]) ) do |o|
        Window.draw o.x , o.y , o.d
      end
    end 
  end
  if Input.keyPush? K_X
    task.select do | m |
      m.sym =~ /te/
    end.map do | m |
      
      m.d = Image.new(20,20,[200,100,220,220])
      oo = o
      speed = count_limit_create 0.1 , 4   , 0.01
      alpha = count_limit_create 255 , 40  , -1
      rot   = count_loop_create  0   , 500 , 1
      m.func = lambda do |o|
        angle = homing_angle o.x , o.y , oo.x , oo.y
        o.x , o.y = move o.x , o.y , speed.call , angle     
        Window.drawEx( o.x , o.y , o.d , { alpha: alpha.call , angle: rot.call })
        if blockhit( o.x , o.y , o.d.width , o.d.height , oo.x , oo.y , oo.d.width , oo.d.height  )
           task -= [o]
        end
      end
    end
  end
  
end


100.times do |i|
  task << O.new( sym: :te , x:rand(600), y: rand(500) , d:Image.new(20,20,[200,100,120,220]) ) do |o|
    Window.draw o.x , o.y , o.d
  end
end

font = Font.new(30)
Window.loop do
  task.each do |o|
    o.update
  end
  [
  "Pleace Z Key is Shot" ,
  "Pleace X Key is Object Clear Homing" ,
  "Pleace C Key is Object Create" ,
  "Objects to #{task.size} " ,
  ].each_with_index do | m , i |
    Window.drawFont 0 ,  50 + i*50 , m , font , { alpha: 200 , color: [220,170,220] }
  end
end

