#coding : utf-8
require "dxruby"

class Effect
  def initialize command #  x , y , img , w
    @command = command
    @x    = 20  + rand(240)
    @y    = 100 + rand(150)
    @font = Font.new 40
#    @img  = Image.new(100,100,[0,0,0,0]).drawFont( 0, 0 , "" , @font )
    @wait = 155
  end
  def update task
#    Window.drawEx @x , @y , @img , alpha: @wait
    Window.drawFont @x , @y , @command , @font , alpha: @wait , color: [180,180,230]
    @y += 0.1
    @wait -= 1
    if @wait < 1
      task.delete self
    end
  end
end

module My_Input

  @@__My_Input__key_wait  ||= Hash.new { |s,k| s[k] = [] }  
  @@__My_Input__key_stack ||= Hash.new { |s,k| s[k] = [] }  
  
  def mupdate
    kw    = @@__My_Input__key_wait
    stack = @@__My_Input__key_stack 
    [
     K_Z , K_X ,
     K_Q , K_W , K_E , K_R ,
     K_DOWN , K_RIGHT , K_LEFT , K_UP ,
    ].each do |m|
      if Input.keyDown? m
        kw[ m ] = 1
      elsif kw[ m ] == 1
        kw[ m ] = 0
        stack[ m ] << true
      end
    end
  end

  def mkey_up? key
    @@__My_Input__key_stack[ key ].shift
  end
end

module Input
  extend My_Input
end



s = "266A"
def f s , n = 0 , d = ""
  case s[n]
  when "6"
    d << "_6"
  when "2"
    d << "_2"
  when "A"
    d << "_A"
  when nil
    return d
  else 
    p "err"
    exit
  end
  f s , n + 1 , d
end

# p f s

task = []
kk = []

font = Font.new 20
# mi si yo u
n = 0
waza = false
#
jo = 0
Window.loop do
  exit if Input.keyPush? K_F9
  
  Input.mupdate

  Window.drawFont 20 , 100 , kk.join , font , color: [200,255,200]

  Window.drawFont 20 , 400 , task.size.to_s , font , color: [200,255,200]
  task.each do |m| m.update task end

  # 第一 初動
  if kk.empty?
    jo = 0
    if Input.keyDown? K_RIGHT
      p 2
      kk << "6"
      jo = 1
    end
  end
  
  # 第二 状態
  case jo
  when 1
    case kk[0]
    when "6"
      if Input.keyDown? K_A
        p 3
        kk << "A"
        jo = 2
      elsif Input.keyDown? K_DOWN  
        p 4
        kk << "2"
        jo = 2
#      elsif Input.keyPush? K_RIGHT
#        jo = 10001
      end
  
    end
  when 10001
    if Input.mkey_up? K_RIGHT
      jo = 10002
      p 22
    end
  when 10002
    if Input.keyDown? K_RIGHT
      p 556
      kk << "6"
      jo = 2
    end
  when 2
  # 第三　状態
#    case kk[1]
#    when "2"
      if Input.keyDown? K_A
        p 5
        kk << "A"
        jo = 3
      end
      
#    end
  end

# 技解読
  if kk.join == "6A"
     task << Effect.new("_6A_")
     kk.clear
  end

  if kk.join == "62A"
     task << Effect.new("_6_2_A_")
     kk.clear
  end

  if kk.join == "66A"
     task << Effect.new("_6_6_A_")
     kk.clear
  end

# time out

  $__c_test ||= 0
 if [ K_DOWN , K_RIGHT , K_UP , K_LEFT ,
      K_Q  , K_W , K_E , K_R ,
    ].map(&->m{Input.keyDown? m}).any?
    $__c_test = 0
 else
    $__c_test += 1
    if $__c_test >  30
      kk.clear
    end
 end
  
end
  