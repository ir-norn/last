#coding:utf-8
require "dxruby"

Dir.chdir File.dirname(File.expand_path(__FILE__))
Window.width = 800
GLOBAL       = Object.new.extend Module.new{attr_accessor :RENDER_MAIN, :RENDER_RIGHT , :TASK, :SCENE , :IMAGE , :SOUND , :SCREEN_PADDING }
GLOBAL.TASK  = Object.new.extend Module.new{attr_accessor :scene, :screen, :screen_collision , :user,:user_shot,:enemy,:enemy_shot }
GLOBAL.TASK.user        = []
GLOBAL.TASK.user_shot   = []
GLOBAL.TASK.enemy       = []
GLOBAL.TASK.enemy_shot  = []
GLOBAL.TASK.scene       = []
GLOBAL.SCREEN_PADDING = Object.new.extend Module.new { attr_accessor :left ,:top,:bottom,:right }
# ここでゲームメインスクリーンの大きさｗ指定してpaddingを自動計算でもいいかも
Game_window_x       = 30
Game_window_y       = 40
Game_window_width   = 500
Game_window_height  = 400
Game_window_RENDER  = RenderTarget.new
exit
GLOBAL.SCREEN_PADDING.left   = 20
GLOBAL.SCREEN_PADDING.top    = 20
GLOBAL.SCREEN_PADDING.bottom = 20
GLOBAL.SCREEN_PADDING.right  = 200
GLOBAL.TASK.screen           = Sprite.new GLOBAL.SCREEN_PADDING.left , GLOBAL.SCREEN_PADDING.top , Image.new(Window.width - GLOBAL.SCREEN_PADDING.right, Window.height - (GLOBAL.SCREEN_PADDING.bottom + GLOBAL.SCREEN_PADDING.top) , [255,255,255])
GLOBAL.RENDER_MAIN                = RenderTarget.new Window.width - GLOBAL.SCREEN_PADDING.right, Window.height - (GLOBAL.SCREEN_PADDING.bottom + GLOBAL.SCREEN_PADDING.top)
GLOBAL.RENDER_RIGHT               = RenderTarget.new GLOBAL.SCREEN_PADDING.right               , Window.height
GLOBAL.TASK.screen_collision      = Sprite.new GLOBAL.SCREEN_PADDING.left - (collision_padding = 100) , GLOBAL.SCREEN_PADDING.top - collision_padding , Image.new((Window.width - GLOBAL.SCREEN_PADDING.right)+collision_padding , (Window.height - (GLOBAL.SCREEN_PADDING.bottom + GLOBAL.SCREEN_PADDING.top))+collision_padding , [255,255,255])
GLOBAL.SCENE                      = Object.new.extend Module.new{attr_accessor :NAME }
GLOBAL.SCENE.NAME                 = "シーン名"
GLOBAL.SOUND                      = Object.new.extend Module.new{attr_accessor :BGM,:SE }
GLOBAL.SOUND.BGM                  = Sound.new "./sound/se3_sample6.wav" # ; sleep 1
GLOBAL.SOUND.SE                   = Object.new.extend Module.new{attr_accessor :USER_SHOT_CREATE, :USER_SHOT_SHOT , :ENEMY_CREATE , :ENEMY_SHOT_CREATE , :ENEMY_HIT ,:ENEMY_SHOT_SHOT , :USER_HIT }
GLOBAL.SOUND.SE.USER_SHOT_CREATE  = Sound.new "./sound/nil.wav"
GLOBAL.SOUND.SE.USER_SHOT_SHOT    = Sound.new "./sound/nil.wav"
GLOBAL.SOUND.SE.ENEMY_HIT         = Sound.new "./sound/nil.wav"
GLOBAL.IMAGE                      = Object.new.extend Module.new{attr_accessor :user, :user_shot , :enemy , :enemy_shot , :background , :padding_left   ,  :padding_top    ,  :padding_bottom ,  :padding_right }
GLOBAL.IMAGE.padding_left    = Image.new( GLOBAL.SCREEN_PADDING.left       , Window.height                , [115,155,125] )
GLOBAL.IMAGE.padding_top     = Image.new( GLOBAL.TASK.screen.image.width   , GLOBAL.SCREEN_PADDING.top    , [195,115,115] )
GLOBAL.IMAGE.padding_bottom  = Image.new( GLOBAL.TASK.screen.image.width   , GLOBAL.SCREEN_PADDING.bottom , [155,215,255] )
GLOBAL.IMAGE.padding_right   = Image.new( GLOBAL.SCREEN_PADDING.right      , Window.height                , [123, 94,125] )
GLOBAL.IMAGE.background      = nil
GLOBAL.IMAGE.user            = Image.new(40,40,[100,100,200])
GLOBAL.IMAGE.user_shot       = Image.new(20,20,[200,100,200])
GLOBAL.IMAGE.enemy           = Image.new(15,10,[140,100,100])
GLOBAL.IMAGE.enemy_shot      = nil
GLOBAL.TASK.scene.push Sprite.new 0                                                            , 0                                                           , GLOBAL.IMAGE.padding_left
GLOBAL.TASK.scene.push Sprite.new GLOBAL.SCREEN_PADDING.left                                   , 0                                                           , GLOBAL.IMAGE.padding_top
GLOBAL.TASK.scene.push Sprite.new GLOBAL.SCREEN_PADDING.left                                   , GLOBAL.SCREEN_PADDING.top + GLOBAL.TASK.screen.image.height , GLOBAL.IMAGE.padding_bottom
GLOBAL.TASK.scene.push Sprite.new GLOBAL.SCREEN_PADDING.left + GLOBAL.TASK.screen.image.width  , 0                                                           , GLOBAL.IMAGE.padding_right


module Game_object ; attr_accessor :speed , :sym    end
class Game_object_main < Sprite
  include Game_object
  def initialize *_
    super
    self.target = GLOBAL.RENDER_MAIN
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
    add = Input.x * @speed ; self.x += add if (self.x + add > 0) and (self.x + add + self.image.width  < GLOBAL.RENDER_MAIN.width  )
    add = Input.y * @speed ; self.y += add if (self.y + add > 0) and (self.y + add + self.image.height < GLOBAL.RENDER_MAIN.height )
    Input.set_repeat(0, 5)
    if Input.key_push? K_Z
      img = GLOBAL.IMAGE.user_shot
      pd  = 5
      GLOBAL.TASK.user_shot << User_shot.new( x - pd             , y , img)
      GLOBAL.TASK.user_shot << User_shot.new( x + pd + img.width , y , img)
    end
    Input.set_repeat(0, 0)
  end
end
class User_shot < Game_object_main
  def initialize x , y , image , sym = :user_shot0
    super x , y , image
    @sym = sym
    @speed = 6
    GLOBAL.SOUND.SE.USER_SHOT_CREATE.play
  end
  def update
    self.y -= @speed
  end
  def shot o
    o.vanish
    GLOBAL.SOUND.SE.USER_SHOT_SHOT.play
  end
end

class Enemy < Game_object_main
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
    GLOBAL.SOUND.SE.ENEMY_HIT.play
  end
end
class Enemy_shot < Game_object_main
end
class Effect ; end
class Scene_progression
  def initialize
    @count = (Array 0..70).cycle
    init
  end
  def init
    GLOBAL.TASK.user << User.new( 180, 300 , GLOBAL.IMAGE.user)
#    GLOBAL.SOUND.BGM.play
  end
  def update
    case @count.next
    when 10..30
      img = GLOBAL.IMAGE.enemy
      y   = 0 - img.width
      GLOBAL.TASK.enemy << Enemy.new(rand(400) , y ,img)

    end
  end
end

def Window.screenshot dir = "_screenshot"
   pwd = Dir.pwd
   Dir.chdir File.dirname(File.expand_path(__FILE__))
   Dir.mkdir( dir ) unless File.exist?( dir )
   file  =  dir + "/sc_" + Time.new.strftime("%Y_%m_%d__%H_%M_%S") + ".jpg"
   Window.getScreenShot( file )
   Dir.chdir pwd
   return file
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
    GLOBAL.RENDER_MAIN.draw_shader(0, 0, @shader_rt, @shader, -100)
  end
end


TASK = GLOBAL.TASK
GLOBAL.TASK.scene << Background.new
GLOBAL.TASK.scene << Scene_progression.new
Window.loop do ; exit if Input.keyPush? K_F9 ; exit if Input.keyPush? K_ESCAPE ; Window.screenshot if Input.keyPush? K_F12
  Sprite.draw   [ TASK.scene , TASK.user , TASK.user_shot , TASK.enemy ]
  Sprite.update [ TASK.scene , TASK.user , TASK.user_shot , TASK.enemy ]
#  Sprite.check  TASK.user , [ TASK.enemy , TASK.enemy_shot ]
  Sprite.check  TASK.user_shot , TASK.enemy
  Sprite.clean [ TASK.user , TASK.user_shot , TASK.enemy ]
  TASK.user_shot = TASK.screen_collision.check TASK.user_shot
  TASK.enemy     = TASK.screen_collision.check TASK.enemy

  GLOBAL.RENDER_MAIN.draw_font 0,  0,"user:#{TASK.user.size}",Font.default
  GLOBAL.RENDER_MAIN.draw_font 0, 20,"user_shot:#{TASK.user_shot.size}",Font.default
  GLOBAL.RENDER_MAIN.draw_font 0, 40,"enemy:#{TASK.enemy.size}",Font.default
  GLOBAL.RENDER_MAIN.draw_font 0, 60,"enemy_shot:#{TASK.enemy_shot.size}",Font.default
  Window.draw_font Window.width-60, Window.height-30,"fps#{Window.fps}",Font.default
  GLOBAL.RENDER_MAIN.update
  GLOBAL.RENDER_RIGHT.update
  Window.draw GLOBAL.SCREEN_PADDING.left , GLOBAL.SCREEN_PADDING.top , GLOBAL.RENDER_MAIN
  Window.draw GLOBAL.SCREEN_PADDING.left + GLOBAL.RENDER_MAIN.width , GLOBAL.SCREEN_PADDING.top , GLOBAL.RENDER_RIGHT
end
