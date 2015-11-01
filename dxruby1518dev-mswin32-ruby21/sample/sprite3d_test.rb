require 'dxruby'

class View
  attr_accessor :m
  def initialize
    @m = Matrix.new
  end
end

class Project
  attr_accessor :m, :zn, :zf, :s
  def initialize(sw, sh, zn, zf)
    @sw = sw
    @sh = sh
    @zn = zn
    @zf = zf
    self.update
  end

  def update
    @m = Matrix.projection(@sw, @sh, @zn, @zf)
    @s = @zn / @m.to_a[0]
  end
end

class ProjectFov
  attr_accessor :m, :zn, :zf, :s
  def initialize(fov, aspect, zn, zf)
    @fov = fov
    @aspect = aspect
    @zn = zn
    @zf = zf
    self.update
  end

  def update
    @m = Matrix.projection_fov(@fov, @aspect, @zn, @zf)
    @s = @zn / @m.to_a[0]
  end
end

class Sprite3D < Sprite
  attr_accessor :v

  def self.set_transform(view, proj, target = nil)
    @@target = target
    if target == nil
      target = Window
    end
    @@view = view
    @@proj = proj
    @@vp = Matrix.new([[ target.width / 2.0, 0.0, 0.0, 0.0],
                       [ 0.0, -target.height / 2.0, 0.0, 0.0],
                       [ 0.0, 0.0, -1.0, 0.0],
                       [ target.width / 2.0, target.height / 2.0, 0.0, 1.0]])
    @@scale = target.width / 2.0
  end

  def initialize(v, image)
    @v = v
    self.image = image
    self.offset_sync = true
    self.center_x = nil
    self.center_y = image.height - 2
    self.target = @@target
  end

  def update
    temp = (Vector.new(0.0,0.0,0.0,1.0) + @v) * @@view.m * @@proj.m
    self.scale_x = self.scale_y = @@proj.zn / temp.w * @@scale / @@proj.s / 3
    self.xyz = temp / temp.w * @@vp
    self.visible = (self.z < 0 and self.z > -1.0)
  end
end

class Polygon
  attr_accessor :image, :view, :m, :z

  hlsl = <<EOS
  float4x4 g_world, g_view, g_proj;
  texture tex0;

  sampler Samp = sampler_state
  {
   Texture =<tex0>;
//   MinFilter = POINT;
//   MagFilter = POINT;
  };

  struct VS_OUTPUT
  {
    float4 pos : POSITION;
    float2 tex : TEXCOORD0;
  };

  VS_OUTPUT VS(float4 pos: POSITION, float2 tex: TEXCOORD0)
  {
    VS_OUTPUT output;

    output.pos = mul(mul(mul(pos, g_world), g_view), g_proj);
    output.tex = tex;

    return output;
  }

  float4 PS(float2 input : TEXCOORD0) : COLOR0
  {
    return tex2D( Samp, input );
  }

  technique
  {
   pass
   {
    VertexShader = compile vs_2_0 VS();
    PixelShader = compile ps_2_0 PS();
   }
  }
EOS

  @@core = Shader::Core.new(hlsl, {:g_world=>:float, :g_view=>:float, :g_proj=>:float})

  def initialize(image, view, proj, z)
    @shader = Shader.new(@@core)
    @view = view
    @proj = proj
    @image = image
    @z = z
    @m = Matrix.new
  end

  def update
    @shader.g_world = @m
    @shader.g_view = @view.m
    @shader.g_proj = @proj.m
  end

  def draw
    Window.draw_shader(0, 0, @image, @shader, -2)
  end
end



view = View.new
proj = ProjectFov.new(30.0, 480.0/640.0, 10, 50000.0)

Sprite3D.set_transform(view, proj)
objects = Array.new(100) {|i|
  Sprite3D.new(Vector.new(rand()*640, rand()*480, 0.0), Image.load("shader_sample/bgimage/image1.png").set_color_key([255,255,255]))
}

#Window.mag_filter = TEXF_POINT
Window.bgcolor = [100, 100, 255]

grand = Polygon.new(Image.load("shader_sample/bgimage/course.png"), view, proj, -3000.0)
grand.m = Matrix.scaling(1.0,1.0,1.0)

z = 10

x = 400
y = 300
angle = 180
speed = 0
dx = 0
dy = 0

Window.loop do
  speed = speed + 0.05 if Input.pad_down?(P_BUTTON0) and speed < 1.5
  speed = speed - 0.05 if Input.pad_down?(P_BUTTON1) and speed > -1
  if Input.pad_down?(P_BUTTON2)
    angle = angle - 2 if Input.pad_down?(P_LEFT)
    angle = angle + 2 if Input.pad_down?(P_RIGHT)
  else
    angle = angle - 1 if Input.pad_down?(P_LEFT)
    angle = angle + 1 if Input.pad_down?(P_RIGHT)
  end
  x += Math.cos(Math::PI / 180 * angle)
  y += Math.sin(Math::PI / 180 * angle)

  view.m = Matrix.look_at(Vector.new(x - Math.cos(Math::PI / 180 * angle), y - Math.sin(Math::PI / 180 * angle), z), Vector.new(x, y, z), Vector.new(0, 0, 1)) * Matrix.rotation_x(-5)

  Sprite.update(objects)
  grand.update
  Sprite.draw(objects)
  grand.draw

  break if Input.key_push?(K_ESCAPE)
end

