require 'dxruby'


hlsl = <<EOS
float4x4 g_world, g_view, g_proj;
texture tex0;

sampler Samp = sampler_state
{
 Texture =<tex0>;
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

core = Shader::Core.new(hlsl, {:g_world=>:float, :g_view=>:float, :g_proj=>:float})
shader = Shader.new(core)

shader.g_view = [1, 0, 0, 0,
                 0, -1, 0, 0,
                 0, 0, 1, 0,
                 -Window.width/2, Window.height/2, 0, 1].to_a

zn = 700.0
zf = 5000.0
sw = 640.0
sh = 480.0
shader.g_proj = [2.0 * zn / sw, 0,                    0, 0,
                 0, 2.0 * zn / sh,                    0, 0,
                 0,             0,       zf / (zf - zn), 1,
                 0,             0, -zn * zf / (zf - zn), 0].to_a

image = [Image.load("bgimage/BG42a.jpg"), Image.load("bgimage/BG00a1_80.jpg"),
         Image.load("bgimage/BG10a_80.jpg"), Image.load("bgimage/BG13a_80.jpg"),
         Image.load("bgimage/BG32a.jpg")]

a=0
Window.loop do
  a += 1
  idx = 0
  image.map{|img|
  idx += 1
    [img,
    Matrix.translation(0,0,-1000) *
    Matrix.rotation_y(a+idx*72) * 
    Matrix.translation(0,0,1000) * 
    Matrix.rotation_x(20) * 
    Matrix.translation(300,300,1500)
    ]
  }.sort_by{|ary|
    -(Vector.new(0,0,0,1) * ary[1]).z
  }.each do |ary|
    shader.g_world = ary[1].to_a
    Window.draw_shader(-ary[0].width/2, -ary[0].height/2, ary[0], shader)
  end
  break if Input.key_push?(K_ESCAPE)
end

