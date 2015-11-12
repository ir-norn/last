#coding:utf-8
require "dxruby"

Dir.chdir File.dirname(File.expand_path(__FILE__))
Window.width  = 800
Window.height = 600
GLOBAL        = Object.new.extend Module.new{attr_accessor :TASK, :SCENE , :IMAGE , :SOUND , :SCREEN_PADDING , :WINDOW_SYSTEM}
GLOBAL.WINDOW_SYSTEM         = Object.new.extend Module.new { attr_accessor :x ,:y,:width,:height , :RENDER , :RENDER_MAIN , :RENDER_LEFT, :RENDER_TOP , :RENDER_BOTTOM ,:RENDER_RIGHT , :TASK }
GLOBAL.WINDOW_SYSTEM.x       = 160
GLOBAL.WINDOW_SYSTEM.y       = 60
GLOBAL.WINDOW_SYSTEM.width   = 600  # Window.width
GLOBAL.WINDOW_SYSTEM.height  = 400  # Window.height
GLOBAL.WINDOW_SYSTEM.RENDER  = RenderTarget.new GLOBAL.WINDOW_SYSTEM.width , GLOBAL.WINDOW_SYSTEM.height
GLOBAL.SCREEN_PADDING        = Object.new.extend Module.new { attr_accessor :left ,:top,:bottom,:right }
GLOBAL.SCREEN_PADDING.left   = 110
GLOBAL.SCREEN_PADDING.top    = 110
GLOBAL.SCREEN_PADDING.bottom = 110
GLOBAL.SCREEN_PADDING.right  = 240
GLOBAL.WINDOW_SYSTEM.RENDER_MAIN   = RenderTarget.new GLOBAL.WINDOW_SYSTEM.width - (GLOBAL.SCREEN_PADDING.left + GLOBAL.SCREEN_PADDING.right)  ,  GLOBAL.WINDOW_SYSTEM.height - (GLOBAL.SCREEN_PADDING.bottom + GLOBAL.SCREEN_PADDING.top)
GLOBAL.WINDOW_SYSTEM.RENDER_LEFT   = RenderTarget.new GLOBAL.SCREEN_PADDING.left                                                               ,  GLOBAL.WINDOW_SYSTEM.height
GLOBAL.WINDOW_SYSTEM.RENDER_TOP    = RenderTarget.new GLOBAL.WINDOW_SYSTEM.width                                                               ,  GLOBAL.SCREEN_PADDING.top
GLOBAL.WINDOW_SYSTEM.RENDER_BOTTOM = RenderTarget.new GLOBAL.WINDOW_SYSTEM.width                                                               ,  GLOBAL.SCREEN_PADDING.bottom
GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT  = RenderTarget.new GLOBAL.SCREEN_PADDING.right                                                              ,  GLOBAL.WINDOW_SYSTEM.height
GLOBAL.IMAGE                       = Object.new.extend Module.new{attr_accessor :user, :user_shot , :enemy , :enemy_shot , :background , :padding_left   ,  :padding_top    ,  :padding_bottom ,  :padding_right }
GLOBAL.IMAGE.padding_left    = Image.new( GLOBAL.SCREEN_PADDING.left              , GLOBAL.WINDOW_SYSTEM.height   , [115,155,125] )
GLOBAL.IMAGE.padding_top     = Image.new( GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width  , GLOBAL.SCREEN_PADDING.top     , [195,115,115] )
GLOBAL.IMAGE.padding_bottom  = Image.new( GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width  , GLOBAL.SCREEN_PADDING.bottom  , [155,215,255] )
GLOBAL.IMAGE.padding_right   = Image.new( GLOBAL.SCREEN_PADDING.right             , GLOBAL.WINDOW_SYSTEM.height   , [123, 94,125] )
GLOBAL.WINDOW_SYSTEM.TASK              = Object.new.extend Module.new{attr_accessor :padding }
GLOBAL.WINDOW_SYSTEM.TASK.padding        = []
GLOBAL.WINDOW_SYSTEM.TASK.padding.push Sprite.new 0                                                                     , 0                                                                   , GLOBAL.IMAGE.padding_left
GLOBAL.WINDOW_SYSTEM.TASK.padding.push Sprite.new GLOBAL.SCREEN_PADDING.left                                            , 0                                                                   , GLOBAL.IMAGE.padding_top
GLOBAL.WINDOW_SYSTEM.TASK.padding.push Sprite.new GLOBAL.SCREEN_PADDING.left                                            , GLOBAL.SCREEN_PADDING.top + GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.height , GLOBAL.IMAGE.padding_bottom
GLOBAL.WINDOW_SYSTEM.TASK.padding.push Sprite.new GLOBAL.SCREEN_PADDING.left + GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width   , 0                                                                   , GLOBAL.IMAGE.padding_right
GLOBAL.WINDOW_SYSTEM.TASK.padding.each do|v| v.target = GLOBAL.WINDOW_SYSTEM.RENDER end

GLOBAL.TASK                    = Object.new.extend Module.new{attr_accessor :scene , :screen_collision , :user,:user_shot,:enemy,:enemy_shot }
GLOBAL.TASK.screen_collision   = Sprite.new GLOBAL.SCREEN_PADDING.left - (collision_padding = 100) , GLOBAL.SCREEN_PADDING.top - collision_padding , Image.new((GLOBAL.WINDOW_SYSTEM.width - GLOBAL.SCREEN_PADDING.right)+collision_padding , (GLOBAL.WINDOW_SYSTEM.height - (GLOBAL.SCREEN_PADDING.bottom + GLOBAL.SCREEN_PADDING.top))+collision_padding , [255,255,255])
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
GLOBAL.IMAGE.background      = nil
GLOBAL.IMAGE.user            = Image.new(40,40,[100,100,200])
GLOBAL.IMAGE.user_shot       = Image.new(20,20,[200,100,200])
GLOBAL.IMAGE.enemy           = Image.new(15,10,[140,100,100])
GLOBAL.IMAGE.enemy_shot      = nil
#GLOBAL.TASK.scene.last.visible = false

module Game_object ; attr_accessor :speed , :sym    end
class Game_object_main < Sprite
  include Game_object
  def initialize *_
    super
    self.target = GLOBAL.WINDOW_SYSTEM.RENDER_MAIN
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
    add = Input.x * @speed ; self.x += add if (self.x + add > 0) and (self.x + add + self.image.width  < GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width  )
    add = Input.y * @speed ; self.y += add if (self.y + add > 0) and (self.y + add + self.image.height < GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.height )
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
    GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.draw_shader(0, 0, @shader_rt, @shader, -100)
  end
end


class Window_system_class
  def initialize x: , y: , width: , height: , render: , layout: nil
    @render = render
    @my_GLOBAL        = Object.new.extend Module.new{attr_accessor :TASK, :SCENE , :IMAGE , :SOUND , :SCREEN_PADDING , :WINDOW_SYSTEM}
    @my_GLOBAL.WINDOW_SYSTEM           = Object.new.extend Module.new { attr_accessor :x ,:y,:width,:height , :RENDER , :RENDER_MAIN , :RENDER_LEFT, :RENDER_TOP , :RENDER_BOTTOM ,:RENDER_RIGHT , :TASK }
    @my_GLOBAL.WINDOW_SYSTEM.x         = x
    @my_GLOBAL.WINDOW_SYSTEM.y         = y
    @my_GLOBAL.WINDOW_SYSTEM.width     = width  # Window.width
    @my_GLOBAL.WINDOW_SYSTEM.height    = height  # Window.height
    @my_GLOBAL.WINDOW_SYSTEM.RENDER    = RenderTarget.new @my_GLOBAL.WINDOW_SYSTEM.width , @my_GLOBAL.WINDOW_SYSTEM.height
    @my_GLOBAL.WINDOW_SYSTEM.TASK      = Object.new.extend Module.new{attr_accessor :main }
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main = []
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.push Sprite.new 0, 0, Image.new( @my_GLOBAL.WINDOW_SYSTEM.width , @my_GLOBAL.WINDOW_SYSTEM.height , [255,255,155] )
    @layout_task = []
    set_layout layout
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.each do|v| v.target = @my_GLOBAL.WINDOW_SYSTEM.RENDER end
  end
  def render
    @my_GLOBAL.WINDOW_SYSTEM.RENDER
  end
  def render_main
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN
  end
  def render_left
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_LEFT
  end
  def render_top
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_TOP
  end
  def render_bottom
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_BOTTOM
  end
  def render_right
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT
  end
  def layout_draw
    #Sprite.draw @my_GLOBAL.WINDOW_SYSTEM.TASK.main
    # Sprite.draw [ @my_GLOBAL.WINDOW_SYSTEM.TASK.main , @layout_task ]
    # Sprite.draw [ @my_GLOBAL.WINDOW_SYSTEM.TASK.main , @layout_task ]
  end
  def update
    @my_GLOBAL.WINDOW_SYSTEM.RENDER.update
  end
  def draw
    @render.draw @my_GLOBAL.WINDOW_SYSTEM.x , @my_GLOBAL.WINDOW_SYSTEM.y , @my_GLOBAL.WINDOW_SYSTEM.RENDER
  end
  def set_layout layout
    case layout
    when :default

    @my_GLOBAL.SCREEN_PADDING        = Object.new.extend Module.new { attr_accessor :left ,:top,:bottom,:right }
    @my_GLOBAL.SCREEN_PADDING.left   = 10
    @my_GLOBAL.SCREEN_PADDING.top    = 10
    @my_GLOBAL.SCREEN_PADDING.bottom = 10
    @my_GLOBAL.SCREEN_PADDING.right  = 10
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN   = RenderTarget.new @my_GLOBAL.WINDOW_SYSTEM.width - (@my_GLOBAL.SCREEN_PADDING.left + @my_GLOBAL.SCREEN_PADDING.right)  ,  @my_GLOBAL.WINDOW_SYSTEM.height - (@my_GLOBAL.SCREEN_PADDING.bottom + @my_GLOBAL.SCREEN_PADDING.top)
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_LEFT   = RenderTarget.new @my_GLOBAL.SCREEN_PADDING.left                                                               ,  @my_GLOBAL.WINDOW_SYSTEM.height
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_TOP    = RenderTarget.new @my_GLOBAL.WINDOW_SYSTEM.width                                                               ,  @my_GLOBAL.SCREEN_PADDING.top
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_BOTTOM = RenderTarget.new @my_GLOBAL.WINDOW_SYSTEM.width                                                               ,  @my_GLOBAL.SCREEN_PADDING.bottom
    @my_GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT  = RenderTarget.new @my_GLOBAL.SCREEN_PADDING.right                                                              ,  @my_GLOBAL.WINDOW_SYSTEM.height
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.push Sprite.new @my_GLOBAL.SCREEN_PADDING.left                                                , @my_GLOBAL.SCREEN_PADDING.top                                               , Image.new( @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width  , @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.height   , [205,225,225] )
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.push Sprite.new 0                                                                             , 0                                                                           , Image.new( @my_GLOBAL.SCREEN_PADDING.left              , @my_GLOBAL.WINDOW_SYSTEM.height               , [115,155,125] )
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.push Sprite.new @my_GLOBAL.SCREEN_PADDING.left                                                , 0                                                                           , Image.new( @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width  , @my_GLOBAL.SCREEN_PADDING.top                 , [195,115,115] )
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.push Sprite.new @my_GLOBAL.SCREEN_PADDING.left                                                , @my_GLOBAL.SCREEN_PADDING.top + @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.height , Image.new( @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width  , @my_GLOBAL.SCREEN_PADDING.bottom              , [155,215,255] )
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.push Sprite.new @my_GLOBAL.SCREEN_PADDING.left + @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width   , 0                                                                           , Image.new( @my_GLOBAL.SCREEN_PADDING.right             , @my_GLOBAL.WINDOW_SYSTEM.height               , [123, 94,125] )
    @my_GLOBAL.WINDOW_SYSTEM.TASK.main.each do|v| v.target = @my_GLOBAL.WINDOW_SYSTEM.RENDER end

    func = Object.new.extend Module.new{attr_accessor :update }
    func.update = -> do
      @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.draw_font 10,  0,"xxxxxx",Font.default
      @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.update   ;  @my_GLOBAL.WINDOW_SYSTEM.RENDER.draw @my_GLOBAL.SCREEN_PADDING.left                                              , @my_GLOBAL.SCREEN_PADDING.top                                            , @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN
      @my_GLOBAL.WINDOW_SYSTEM.RENDER_LEFT.update   ;  @my_GLOBAL.WINDOW_SYSTEM.RENDER.draw 0                                                                           , 0                                                                    , @my_GLOBAL.WINDOW_SYSTEM.RENDER_LEFT
      @my_GLOBAL.WINDOW_SYSTEM.RENDER_TOP.update    ;  @my_GLOBAL.WINDOW_SYSTEM.RENDER.draw @my_GLOBAL.SCREEN_PADDING.left                                              , 0                                                                    , @my_GLOBAL.WINDOW_SYSTEM.RENDER_TOP
      @my_GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT.update  ;  @my_GLOBAL.WINDOW_SYSTEM.RENDER.draw @my_GLOBAL.SCREEN_PADDING.left + @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width , 0                                                                    , @my_GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT
      @my_GLOBAL.WINDOW_SYSTEM.RENDER_BOTTOM.update ;  @my_GLOBAL.WINDOW_SYSTEM.RENDER.draw @my_GLOBAL.SCREEN_PADDING.left                                              , @my_GLOBAL.SCREEN_PADDING.top + @my_GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.height  , @my_GLOBAL.WINDOW_SYSTEM.RENDER_BOTTOM
    end
    @layout_task.push func


    end # case
  end
end

TASK = GLOBAL.TASK
#GLOBAL.TASK.scene << Background.new
#GLOBAL.TASK.scene << Scene_progression.new
# GLOBAL.TASK.scene << Window_system_class.new( 10 , 10 , 100 , 200 )
win = Window_system_class.new( x: 10 , y: 10 , width: 300, height: 400 , render: Window ,
 layout: :default
)

Window.loop do ; exit if Input.keyPush? K_F9 ; exit if Input.keyPush? K_ESCAPE ; Window.screenshot if Input.keyPush? K_F12

  Sprite.draw GLOBAL.WINDOW_SYSTEM.TASK.padding
  Sprite.draw   [ TASK.scene , TASK.user , TASK.user_shot , TASK.enemy ]
  Sprite.update [ TASK.scene , TASK.user , TASK.user_shot , TASK.enemy ]
#  Sprite.check  TASK.user , [ TASK.enemy , TASK.enemy_shot ]
  Sprite.check  TASK.user_shot , TASK.enemy
  Sprite.clean [ TASK.user , TASK.user_shot , TASK.enemy ]
  TASK.user_shot = TASK.screen_collision.check TASK.user_shot
  TASK.enemy     = TASK.screen_collision.check TASK.enemy

  win.update
  win.layout_draw
  win.render_main.draw_font 0,  0,"uxxxxser:#{TASK.user.size}",Font.default
  win.draw
  # GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT.draw_font 10,  0,"user:#{TASK.user.size}",Font.default
  GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT.draw_font 10, 20,"user_shot:#{TASK.user_shot.size}",Font.default
  GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT.draw_font 10, 40,"enemy:#{TASK.enemy.size}",Font.default
  GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT.draw_font 10, 60,"enemy_shot:#{TASK.enemy_shot.size}",Font.default
  Window.draw_font GLOBAL.WINDOW_SYSTEM.width-60, GLOBAL.WINDOW_SYSTEM.height-30,"fps#{Window.fps}",Font.default

  GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.update
  GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT.update
  GLOBAL.WINDOW_SYSTEM.RENDER_BOTTOM.update
  GLOBAL.WINDOW_SYSTEM.RENDER_LEFT.update
  GLOBAL.WINDOW_SYSTEM.RENDER_TOP.update

  GLOBAL.WINDOW_SYSTEM.RENDER.draw 0                                                                   , 0                                                                    , GLOBAL.WINDOW_SYSTEM.RENDER_LEFT
  GLOBAL.WINDOW_SYSTEM.RENDER.draw GLOBAL.SCREEN_PADDING.left                                          , 0                                                                    , GLOBAL.WINDOW_SYSTEM.RENDER_TOP
  GLOBAL.WINDOW_SYSTEM.RENDER.draw GLOBAL.SCREEN_PADDING.left + GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width , 0                                                                    , GLOBAL.WINDOW_SYSTEM.RENDER_RIGHT
  GLOBAL.WINDOW_SYSTEM.RENDER.draw GLOBAL.SCREEN_PADDING.left                                          , GLOBAL.SCREEN_PADDING.top + GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.height  , GLOBAL.WINDOW_SYSTEM.RENDER_BOTTOM
  GLOBAL.WINDOW_SYSTEM.RENDER.draw GLOBAL.SCREEN_PADDING.left                                          , GLOBAL.SCREEN_PADDING.top                                            , GLOBAL.WINDOW_SYSTEM.RENDER_MAIN
  GLOBAL.WINDOW_SYSTEM.RENDER.update
  Window.draw GLOBAL.WINDOW_SYSTEM.x , GLOBAL.WINDOW_SYSTEM.y , GLOBAL.WINDOW_SYSTEM.RENDER
  # Window.draw GLOBAL.SCREEN_PADDING.left , GLOBAL.SCREEN_PADDING.top , GLOBAL.WINDOW_SYSTEM.RENDER_MAIN
#  Window.draw GLOBAL.SCREEN_PADDING.left + GLOBAL.WINDOW_SYSTEM.RENDER_MAIN.width , GLOBAL.SCREEN_PADDING.top , GLOBAL.RENDER_RIGHT
#  Window.draw GLOBAL.WINDOW_SYSTEM.x , GLOBAL.WINDOW_SYSTEM.y , GLOBAL.WINDOW_SYSTEM.RENDER
end
