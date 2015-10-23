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



font = Font.new 20
cst  = []
task = []
Window.loop do 
  Input.mupdate

  exit if Input.keyPush? K_F9

  Window.drawFont 20 , 50 , cst.join , font , color: [200,255,200]

  Window.drawFont 20 , 400 , task.size.to_s , font , color: [200,255,200]
  task.each do |m| m.update task end


  if Input.keyDown? K_LEFT
    cst << "4"
  end
  if Input.keyDown? K_RIGHT
    cst << "6"
  end
  if Input.keyDown? K_UP
    cst << "8"
  end
  if Input.keyDown? K_DOWN
    cst << "2"
  end

# bottom

  if Input.keyPush? K_Q
    cst << "q"
  end
  if Input.keyPush? K_W
    cst << "w"
  end
  
  if Input.keyPush? K_E
    cst << "e"
  end
  if Input.keyPush? K_R
    cst << "r"
  end
  

# key_up

  if Input.mkey_up? K_DOWN
    if cst.last == "2"
      cst << "x"
    end
  end
  if Input.mkey_up? K_UP
    if cst.last == "8"
      cst << "d"
    end
  end
  if Input.mkey_up? K_LEFT
    if cst.last == "4"
      cst << "z"
    end
  end  
  if Input.mkey_up? K_RIGHT
    if cst.last == "6"
      cst << "c"
    end
  end


  miu = /([2|4|6|8|x|c|z|d|q|w|e|r]{0,3})/
  case cst.join

# ---------q---------------
  # /^4+z?2+x?6+c?#{miu}q/
  when /^6+c?2+x?4+z?#{miu}q/
    task << Effect.new("command_33 →↓←q")
    cst.clear
  when /^4+z?2+x?6+c?#{miu}q/
    task << Effect.new("command_2 ←↓→q")
    cst.clear

  when /^2+x?6+c?2+x?#{miu}q/
    task << Effect.new("q悉皆彷徨   ↓→↓q")
    cst.clear

  when /^2+x?4+z?2+x?#{miu}q/
    task << Effect.new("q悉皆彷徨rev   ↓←↓q")
    cst.clear

  # ため技
  when /^2+x?(6{15,})c?#{miu}q/
    p $1.size
    task << Effect.new("幽胡蝶_ex ↓→q")
    cst.clear
  when /^2+x?6+c?#{miu}q/
    task << Effect.new("幽胡蝶 ↓→q")
    cst.clear
  when /^2+x2+#{miu}q/
    task << Effect.new("qクラッシュ ↓↓q")
    cst.clear
  when /^2+x?4+z?#{miu}q/
    task << Effect.new("q未生の光  ↓←q")
    cst.clear
  when /^6+c?2+x?#{miu}q/
    task << Effect.new("q胡蝶夢の舞    ↓→↓q")
    cst.clear
    
# -------------w---e---r------

  when /^2+x2+#{miu}w/
    task << Effect.new("wクラッシュ ↓↓w")
    cst.clear
  when /^2+x2+#{miu}e/
    task << Effect.new("霊激 ↓↓e")
    cst.clear
  when /^2+x2+#{miu}r/
    task << Effect.new("スペカ宣言 ↓↓r")
    cst.clear


  end
  
  # stack delete
  
  $__c_test ||= 0
  if Input.keyDown?(K_DOWN) or
    Input.keyDown?(K_LEFT)  or
    Input.keyDown?(K_UP)    or
    Input.keyDown?(K_DOWN)  or
    Input.keyDown?(K_RIGHT) or
    Input.keyDown?(K_Q)     or
    Input.keyDown?(K_W)     or
    Input.keyDown?(K_E)     or
    Input.keyDown?(K_R)
    $__c_test = 0
  else
    $__c_test += 1
    if $__c_test >  30
      cst.clear
    end
  end

  $__n ||= 0
  if cst.empty?.!
    $__n += 1
    if $__n % 30  == 0
      cst.shift
    end
  else
    $__n = 0
  end

end




__END__

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

