#coding:utf-8
require "dxruby"

Dir.chdir File.dirname(File.expand_path(__FILE__))
Window.width  = 800
Window.height = 600
GLOBAL        = Object.new.extend Module.new{attr_accessor :TASK, :SCENE , :IMAGE , :SOUND }
GLOBAL.TASK   = Object.new.extend Module.new{attr_accessor :scene , :screen_collision , :user,:user_shot,:enemy,:enemy_shot }
GLOBAL.TASK.scene       = []
GLOBAL.TASK.user        = []
GLOBAL.TASK.user_shot   = []
GLOBAL.TASK.enemy       = []
GLOBAL.TASK.enemy_shot  = []
GLOBAL.SCENE                       = Object.new.extend Module.new{attr_accessor :NAME }
GLOBAL.SCENE.NAME                  = "シーン名"
GLOBAL.SOUND                       = Object.new.extend Module.new{attr_accessor :BGM,:SE }
GLOBAL.SOUND.BGM                   = Sound.new "./sound/se3_sample6.wav" # ; sleep 1
GLOBAL.SOUND.SE                    = Object.new.extend Module.new{attr_accessor :USER_SHOT_CREATE, :USER_SHOT_SHOT , :ENEMY_CREATE , :ENEMY_SHOT_CREATE , :ENEMY_HIT ,:ENEMY_SHOT_SHOT , :USER_HIT }
GLOBAL.SOUND.SE.USER_SHOT_CREATE   = Sound.new "./sound/nil.wav"
GLOBAL.SOUND.SE.USER_SHOT_SHOT     = Sound.new "./sound/nil.wav"
GLOBAL.SOUND.SE.ENEMY_HIT          = Sound.new "./sound/nil.wav"
GLOBAL.IMAGE  = Object.new.extend Module.new{attr_accessor :user, :user_shot , :enemy , :enemy_shot , :background , :padding_left   ,  :padding_top    ,  :padding_bottom ,  :padding_right }
GLOBAL.IMAGE.background      = nil
GLOBAL.IMAGE.user            = Image.new(40,40,[100,100,200])
GLOBAL.IMAGE.user_shot       = Image.new(20,20,[200,100,200])
GLOBAL.IMAGE.enemy           = Image.new(15,10,[140,100,100])
GLOBAL.IMAGE.enemy_shot      = nil
#GLOBAL.TASK.scene.last.visible = false

class Window_system_class
  def initialize x: , y: , width: , height: , render: , layout: nil
    @render           = render
    @window           = Object.new.extend Module.new{attr_accessor :x ,:y,:width,:height , :RENDER }
    @window.x         = x
    @window.y         = y
    @window.width     = width  # Window.width
    @window.height    = height  # Window.height
    @window.RENDER    = RenderTarget.new @window.width , @window.height
    @task             = Object.new.extend Module.new{attr_accessor :main }
    @task.main        = []
    @task.main.push Sprite.new 0, 0, Image.new( @window.width , @window.height , [235,235,155] )
    set_layout layout
    @task.main.each do|v| v.target = @window.RENDER end
  end
  def render
    @window.RENDER
  end
  def layout_draw
    Sprite.draw @task.main
  end
  def update
    @window.RENDER.update
  end
  def draw
    @render.draw @window.x , @window.y , @window.RENDER
  end
  attr_reader :padding
  def set_layout layout
    @padding        = Object.new.extend Module.new { attr_accessor :left ,:top,:bottom,:right }
    padding.left   = 0
    padding.top    = 0
    padding.bottom = 0
    padding.right  = 0
    case layout
    when :default
    padding.left   = 20
    padding.top    = 30
    padding.bottom = 20
    padding.right  = 200
    @task.main.push Sprite.new padding.left                                                   , padding.top                                                    , Image.new( @window.width - (padding.left + padding.right) , @window.height - (padding.bottom + padding.top)   , [205,225,225] )
    @task.main.push Sprite.new 0                                                              , 0                                                              , Image.new( padding.left                                   , @window.height                                    , [115,155,125] )
    @task.main.push Sprite.new padding.left                                                   , 0                                                              , Image.new(@window.width - (padding.left + padding.right)  , padding.top                                       , [195,115,115] )
    @task.main.push Sprite.new padding.left                                                   , padding.top +  @window.height - (padding.bottom + padding.top) , Image.new( @window.width - (padding.left + padding.right) , padding.bottom                                    , [155,215,255] )
    @task.main.push Sprite.new padding.left +  @window.width - (padding.left + padding.right) , 0                                                              , Image.new( padding.right                                  , @window.height                                    , [123, 94,125] )

    end # case
  end
end

module Game_object ; attr_accessor :speed , :sym    end
class Game_object_main < Sprite
  include Game_object
  def initialize *_
    super
    self.target = WIN.render
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
    add = Input.x * @speed ; self.x += add if   (self.x + add > 0) and (self.x + add + self.image.width  < WIN.render.width  )
    add = Input.y * @speed ; self.y += add if   (self.y + add > 0) and (self.y + add + self.image.height < WIN.render.height )
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
class Enemy_shot < Game_object_main ; end
class Effect ; end
class Scene_progression
  def initialize
    @count = (Array 0..70).cycle
    init
  end
  def init
    GLOBAL.TASK.user << User.new( 180, 300 , GLOBAL.IMAGE.user) # GLOBAL.SOUND.BGM.play
  end
  def update
    case @count.next
    when 10..30
      img = GLOBAL.IMAGE.enemy
      y   = 0 - img.width
      GLOBAL.TASK.enemy << Enemy.new(rand(380) , y ,img)

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
    WIN.render.draw_shader(0, 0, @shader_rt, @shader, -100)
  end
end


WIN = Window_system_class.new( x: 10 , y: 10 , width: 600, height: 400 , render: Window , layout: nil )

GLOBAL.TASK.screen_collision   = Sprite.new WIN.padding.left - (collision_padding = 100) , WIN.padding.top - collision_padding ,
   Image.new((WIN.render.width - WIN.padding.right) + collision_padding ,
   (WIN.render.height - (WIN.padding.bottom + WIN.padding.top)) + collision_padding , [255,255,255])



TASK = GLOBAL.TASK
GLOBAL.TASK.scene << Background.new
GLOBAL.TASK.scene << Scene_progression.new
# GLOBAL.TASK.scene << Window_system_class.new( 10 , 10 , 100 , 200 )


Window.loop do ; exit if Input.keyPush? K_F9 ; exit if Input.keyPush? K_ESCAPE ; Window.screenshot if Input.keyPush? K_F12
  WIN.update
  WIN.layout_draw

#  Sprite.draw GLOBAL.WINDOW_SYSTEM.TASK.padding
  Sprite.draw   [ TASK.scene , TASK.user , TASK.user_shot , TASK.enemy ]
  Sprite.update [ TASK.scene , TASK.user , TASK.user_shot , TASK.enemy ]
#  Sprite.check  TASK.user , [ TASK.enemy , TASK.enemy_shot ]
  Sprite.check   TASK.user_shot , TASK.enemy
  Sprite.clean [ TASK.user , TASK.user_shot ,  TASK.enemy ]
  TASK.user_shot = TASK.screen_collision.check TASK.user_shot
  TASK.enemy     = TASK.screen_collision.check TASK.enemy

  WIN.render.draw_font 10,  0,"uxxxxser:#{TASK.user.size}",Font.default
  WIN.render.draw_font 10, 20,"user_shot:#{TASK.user_shot.size}",Font.default
  WIN.render.draw_font 10, 40,"enemy:#{TASK.enemy.size}",Font.default
  WIN.render.draw_font 10, 60,"enemy_shot:#{TASK.enemy_shot.size}",Font.default
  WIN.draw

end
