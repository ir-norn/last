#coding:utf-8
require "dxruby"

Dir.chdir File.dirname(File.expand_path(__FILE__))
Window.width = 640

GLOBAL = Module.new{extend Module.new{attr_accessor :RENDER_TARGET, :TASK, :SCENE }}
GLOBAL.RENDER_TARGET = RenderTarget.new Window.width, Window.height
GLOBAL.TASK = Object.new.extend Module.new { attr_accessor \
  :screen_padding,
  :screen_padding_left,
  :screen_padding_top,
  :screen_padding_right,
  :screen_padding_bottom,
  :scene,
  :screen,
  :user,:user_shot,:enemy,:enemy_shot }
GLOBAL.TASK.user        = []
GLOBAL.TASK.user_shot   = []
GLOBAL.TASK.enemy       = []
GLOBAL.TASK.enemy_shot  = []
GLOBAL.TASK.scene       = []
#GLOBAL.TASK.screen_padding      = Sprite.new 0, 0
#GLOBAL.TASK.screen.collision = [0, 0, Window.width, Window.height]
#GLOBAL.TASK.screen_padding.collision_enable = false
GLOBAL.TASK.screen           = Sprite.new 20, 20 , Image.new(Window.width-200, Window.height-20,[255,255,255])
GLOBAL.TASK.screen.visible   = false
screen_padding_top   = Sprite.new 0, 0 , Image.new(Window.width-200, 20,[255,255,255])
#screen_padding_right = Sprite.new 0, 0 , Image.new(Window.width-200, 20,[255,255,255])
GLOBAL.TASK.user << screen_padding_top
# GLOBAL.TASK.scene << Sprite.new 0, 20 , Image.new(200, 20,[255,255,255])

#GLOBAL.TASK.SCREEN_MAIN = Sprite.new 0, 0 , Image,new(1,1,[255,255,255])
#GLOBAL.TASK.SCREEN_MAIN.collision = [20, 20, Window.width-200, Window.height-20]
GLOBAL.SCENE       = Object.new.extend Module.new{attr_accessor :BGM,:SE }
GLOBAL.SCENE.BGM   = Sound.new "./sound/se3_sample6.wav"
GLOBAL.SCENE.SE    = Object.new.extend Module.new{attr_accessor :USER_SHOT_CREATE, :USER_SHOT_SHOT , :ENEMY , :ENEMY_SHOT }
GLOBAL.SCENE.SE.USER_SHOT_CREATE  = Sound.new "./sound/nil.wav"
GLOBAL.SCENE.SE.USER_SHOT_SHOT    = Sound.new "./sound/nil.wav"

module Game_object ; attr_accessor :speed , :sym    end
class User < Sprite ; include Game_object
  def initialize x , y , image , sym = :user0
    super x , y , image
    @sym = sym
    @speed = 4
    self.collision = [ 0 , 0 , ]
  end
  def update
    self.x += Input.x * @speed
    self.y += Input.y * @speed
    if GLOBAL.TASK.screen.check(self).empty?
      self.x -= Input.x * self.image.width
      self.y -= Input.y * self.image.height
    end
    Input.set_repeat(0, 5)
    if Input.key_push? K_Z
      img = Image.new(20,20,[200,100,200])
      pd  = 5
      GLOBAL.TASK.user_shot << User_shot.new( x - pd             , y , img)
      GLOBAL.TASK.user_shot << User_shot.new( x + pd + img.width , y , img)
    end
    Input.set_repeat(0, 0)
  end
end
class User_shot < Sprite ; include Game_object
  def initialize x , y , image , sym = :user_shot0
    super x , y , image
    @sym = sym
    @speed = 6
    GLOBAL.SCENE.SE.USER_SHOT_CREATE.play
  end
  def update
    self.y -= @speed
  end
  def shot o
    o.vanish
    GLOBAL.SCENE.SE.USER_SHOT_SHOT.play
  end
end

class Enemy < Sprite ; include Game_object
  def initialize x , y , image , sym = :user_enemy0
    super x , y , image
    @sym = sym
    @speed = 1
  end
  def update
    self.y += @speed
  end
  def hit o
    o.vanish
  end
end
class Enemy_shot < Sprite ; include Game_object ; end
class Effect ; end
class Scene_progression
  def initialize
    @scene_name = "シーン名"
    @count = (Array 0..70).cycle
    init
  end
  def init
    GLOBAL.TASK.user << User.new( 180, 300 , Image.new(40,40,[100,100,200]))
#    SCENE_BGM.play
  end
  def update
    case @count.next
    when 10..30
      y = GLOBAL.TASK.screen.x
      GLOBAL.TASK.enemy << Enemy.new( rand(400) , y , Image.new(15,10,[140,100,100]))

    end
  end
end


scene_progression = Scene_progression.new

Window.loop do ; exit if Input.keyPush? K_F9 ; exit if Input.keyPush? K_ESCAPE
  Sprite.update scene_progression
  Sprite.draw   [ GLOBAL.TASK.user , GLOBAL.TASK.user_shot , GLOBAL.TASK.enemy ]
  Sprite.update [ GLOBAL.TASK.user , GLOBAL.TASK.user_shot , GLOBAL.TASK.enemy]
  Sprite.check  GLOBAL.TASK.user
  Sprite.check GLOBAL.TASK.user_shot , GLOBAL.TASK.enemy
  Sprite.clean [ GLOBAL.TASK.user , GLOBAL.TASK.user_shot , GLOBAL.TASK.enemy ]
  GLOBAL.TASK.user_shot = GLOBAL.TASK.screen.check GLOBAL.TASK.user_shot
  GLOBAL.TASK.enemy     = GLOBAL.TASK.screen.check GLOBAL.TASK.enemy

  GLOBAL.RENDER_TARGET.draw_font 0,  0,"user:#{GLOBAL.TASK.user.size}",Font.default
  GLOBAL.RENDER_TARGET.draw_font 0, 20,"user_shot:#{GLOBAL.TASK.user_shot.size}",Font.default
  GLOBAL.RENDER_TARGET.draw_font 0, 40,"enemy:#{GLOBAL.TASK.enemy.size}",Font.default
  GLOBAL.RENDER_TARGET.draw_font 0, 60,"enemy_shot:#{GLOBAL.TASK.enemy_shot.size}",Font.default
  GLOBAL.RENDER_TARGET.draw_font 0,440,"fps#{Window.fps}",Font.default
  GLOBAL.RENDER_TARGET.update
  Window.draw 10,10,GLOBAL.RENDER_TARGET
end
