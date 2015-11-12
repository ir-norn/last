
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
    padding.left   = 0 ; padding.top    = 0 ; padding.bottom = 0 ; padding.right  = 0
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


#SCENE = Window_system_class.new( x: 40 , y: 60 , width: 600, height: 400 , render: Window , layout: nil )

# GLOBAL.TASK.screen_collision   = Sprite.new SCENE.padding.left - (collision_padding = 100) , SCENE.padding.top - collision_padding ,
#    Image.new((SCENE.render.width - SCENE.padding.right) + collision_padding ,
#    (SCENE.render.height - (SCENE.padding.bottom + SCENE.padding.top)) + collision_padding , [255,255,255])
