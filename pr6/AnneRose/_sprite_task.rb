#coding:utf-8
require "dxruby"

Dir.chdir File.dirname(File.expand_path(__FILE__))
Window.width  = 400
Window.height = 400
TASK            = Object.new.extend Module.new{attr_accessor :scene , :scene_sys , :user,:user_shot,:enemy,:enemy_shot , :effect}
TASK.scene      = []
TASK.scene_sys  = []
TASK.effect     = []
TASK.user       = []
TASK.user_shot  = []
TASK.enemy      = []
TASK.enemy_shot = []
  RENDER     = RenderTarget.new Window.width , Window.height
  SCREEN  = Sprite.new 0 - (cpad = 100) , 0 - cpad , Image.new(Window.width + cpad , Window.height + cpad , [255,255,255])
  TASK.scene_sys.push RENDER , SCREEN
SOUND                       = Object.new.extend Module.new{attr_accessor :BGM,:SE }
SOUND.BGM                   = Sound.new "./sound/se3_sample6.wav" # ; sleep 1
SOUND.SE                    = Object.new.extend Module.new{attr_accessor :USER_SHOT_CREATE, :USER_SHOT_SHOT , :ENEMY_CREATE , :ENEMY_SHOT_CREATE , :ENEMY_HIT ,:ENEMY_SHOT_SHOT , :USER_HIT }
SOUND.SE.USER_SHOT_CREATE   = Sound.new "./sound/nil.wav"
SOUND.SE.USER_SHOT_SHOT     = Sound.new "./sound/nil.wav"
SOUND.SE.ENEMY_HIT          = Sound.new "./sound/nil.wav"
IMAGE                 = Object.new.extend Module.new{attr_accessor :user, :user_shot , :enemy , :enemy_shot ,  :effect , :background }
IMAGE.background      = nil
IMAGE.user            = Image.new(40,40,[100,100,200])
IMAGE.user_shot       = Image.new(20,20,[200,100,200])
IMAGE.enemy           = Image.new(15,10,[140,100,100])
IMAGE.enemy_shot      = Image.new( 5, 5,[190,180,180])
IMAGE.effect          = Image.new( 5, 5,[200,140,200,200])
#TASK.scene.last.visible = false
def Window.screenshot dir = "_screenshot"
   pwd = Dir.pwd
   Dir.chdir File.dirname(File.expand_path(__FILE__))
   Dir.mkdir( dir ) unless File.exist?( dir )
   file  =  dir + "/sc_" + Time.new.strftime("%Y_%m_%d__%H_%M_%S") + ".jpg"
   Window.getScreenShot( file )
   Dir.chdir pwd
   return file
end

module Game_object ; attr_accessor :speed , :sym    end
class Game_object_main < Sprite
  include Game_object
  def initialize *_
    super
    self.target = RENDER
  end
end
class User < Game_object_main
  def initialize x , y , image , sym = :user0
    super x , y , image
    @sym = sym
    @speed = 4
    self.collision = [ 0 , 0 , ]
  end
  def update
    add = Input.x * @speed ; self.x += add if   (self.x + add > 0) and (self.x + add + self.image.width  < RENDER.width  )
    add = Input.y * @speed ; self.y += add if   (self.y + add > 0) and (self.y + add + self.image.height < RENDER.height )
    Input.set_repeat(0, 5)
    if Input.key_push? K_Z
      img = IMAGE.user_shot
      pd  = 5
      TASK.user_shot << User_shot.new( x - pd             , y , img)
      TASK.user_shot << User_shot.new( x + pd + img.width , y , img)
    end
    Input.set_repeat(0, 0)
  end
end
class User_shot < Game_object_main
  def initialize x , y , image , sym = :user_shot0
    super x , y , image
    @sym = sym
    @speed = 6
    SOUND.SE.USER_SHOT_CREATE.play
  end
  def update
    self.y -= @speed
  end
  def shot o
    o.vanish
    SOUND.SE.USER_SHOT_SHOT.play
  end
end
class Enemy < Game_object_main
  def initialize x , y , image , sym = :user_enemy0
    super x , y , image
    @sym = sym
    @speed = 1
    @count = (Array 0..1000).cycle
  end
  def update
    self.y += @speed
    case @count.next
    when 20
      TASK.enemy_shot << Enemy_shot.new( x , y , IMAGE.enemy_shot)
    end
  end
  def hit o
    o.vanish
    TASK.effect     << Effect.new( x , y , IMAGE.effect)
    SOUND.SE.ENEMY_HIT.play
  end
end
class Enemy_shot < Game_object_main
  def initialize x , y , image , sym = :enemy_shot0
    super x , y , image
    @sym = sym
    @speed = 2
  end
  def update
    self.y += @speed
  end
  def shot o
#    o.vanish
    self.vanish
    SOUND.SE.ENEMY_SHOT_SHOT.play
  end
end
class Effect < Game_object_main
  def initialize x , y , image , sym = :effect0
#    super x , y , image
100.times do
    TASK.effect << Effect_sub.new(x , y , image , 2+rand(10))
    TASK.effect << Effect_sub.new(x , y , image , -2-rand(10))
end
    self.vanish
  end
end
class Effect_sub < Game_object_main
  def initialize x , y , image , speed ,sym = :effect0
    super x , y , image
    @speed = speed
    self.alpha = rand(360)
    self.angle = rand(360)
  end
  def update
    self.x += @speed
  end
end
class Scene_progression
  def initialize
    @count = (Array 0..70).cycle
    init
  end
  def init
    TASK.user << User.new( 180, 300 , IMAGE.user) # SOUND.BGM.play
  end
  def update
    case @count.next
    when 10..30
      TASK.enemy << Enemy.new(rand(380) , -IMAGE.enemy.height ,IMAGE.enemy)
    end
  end
end

class Background < Game_object_main
  def initialize
    hlsl = <<-EOS
      float start;
      float pixel;
      texture tex0;

      sampler Samp = sampler_state
      {
       Texture =<tex0>;
      };

      float4 PS(float2 input : TEXCOORD0) : COLOR0
      {
        input.x += sin(radians(input.y * 360 - start)) * pixel;
        return tex2D( Samp, input );
      }

      technique
      {
        pass
        {
          PixelShader = compile ps_2_0 PS();
        }
      }
    EOS
    @shader = Shader.new Shader::Core.new(hlsl,{:start=>:float, :pixel=>:float})
    @pixel = 150
    @image = Image.new(200, 200).circle_fill(200, 200, 200, [40, 222, 40])
    @shader_rt = RenderTarget.new(@image.width + @pixel * 2, 200)
    @shader.start = 0
    @shader.pixel = @pixel.quo(@shader_rt.width)
    @shader_cycle = (Array 1...360).cycle
  end
  def update
    @shader.start = @shader_cycle.next
    @shader_rt.draw(@pixel, 0, @image).update
#    Window.draw_shader(0, 0, @shader_rt, @shader, -100)
    RENDER.draw_shader(0, 0, @shader_rt, @shader, -100)
  end
end

# TASK.scene << Background.new
TASK.scene_sys << Scene_progression.new
Window.loop do ; exit if Input.keyPush? K_F9 ; exit if Input.keyPush? K_ESCAPE ; Window.screenshot if Input.keyPush? K_F12
  Sprite.update TASK.scene_sys
  Sprite.update [ TASK.user , TASK.user_shot , TASK.enemy , TASK.enemy_shot , TASK.effect , TASK.scene , ]
  Sprite.draw   [ TASK.user , TASK.user_shot , TASK.enemy , TASK.enemy_shot , TASK.effect , TASK.scene , ]
#  Sprite.check    TASK.user      , [ TASK.enemy , TASK.enemy_shot ].flatten

  Sprite.check    TASK.user_shot , [ TASK.enemy , TASK.enemy_shot ].flatten
  Sprite.clean  [ TASK.user , TASK.user_shot ,  TASK.enemy , TASK.enemy_shot]
  TASK.user_shot  = SCREEN.check TASK.user_shot
  TASK.enemy      = SCREEN.check TASK.enemy
  TASK.enemy_shot = SCREEN.check TASK.enemy_shot
  TASK.effect     = SCREEN.check TASK.effect

  RENDER.draw_font 10,  0,"user:#{TASK.user.size}",Font.default
  RENDER.draw_font 10, 20,"user_shot:#{TASK.user_shot.size}",Font.default
  RENDER.draw_font 10, 40,"enemy:#{TASK.enemy.size}",Font.default
  RENDER.draw_font 10, 60,"enemy_shot:#{TASK.enemy_shot.size}",Font.default
  RENDER.draw_font 10, 80,"effect:#{TASK.effect.size}",Font.default
  RENDER.draw_font 10, 100,"fps:#{Window.fps}",Font.default
  Window.draw 0, 0, RENDER

end
