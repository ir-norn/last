require 'dxruby'


hlsl = <<EOS
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

  technique  {
    pass
    {
      PixelShader = compile ps_2_0 PS();
    }
  }
EOS

core = Shader::Core.new(hlsl,{:start=>:float, :pixel=>:float})
shader = Shader.new(core)

pixel = 50
image = Image.new(200, 200).circle_fill(100, 100, 100, [0, 222, 0])
rt = RenderTarget.new(image.width + pixel * 2, 200)

shader.start = 0
shader.pixel = pixel.quo(rt.width)
 v = (Array 1..360).cycle
Window.loop do
  exit if Input.keyPush? K_F9
  shader.start = v.next
  rt.draw(pixel, 0, image).update
  Window.draw_shader(200, 200, rt, shader)
end

exit
require 'dxruby'

hlsl = <<EOS
  float2 size;
  float2 d;
  texture tex0;

  sampler Samp0 = sampler_state
  {
   Texture =<tex0>;
   AddressU = WRAP;
   AddressV = WRAP;
  };

  float4 PS(float2 input : TEXCOORD0) : COLOR0
  {
    float4 output;
    output = tex2D( Samp0, input - d / size);
    return output;
  }

  technique
  {
   pass
   {
    PixelShader = compile ps_2_0 PS();
   }
  }
EOS

core = Shader::Core.new(hlsl,{:size=>:float, :d=>:float})
shader = Shader.new(core)
shader.size = [200, 200]

image = Image.new(200, 200).circle_fill(100, 100, 100, [0, 255, 0])

x = 0
Window.loop do
  exit if Input.keyPush? K_F9
  x -= 1
  shader.d = [x, 0]
  Window.draw_shader(200, 200, image, shader)
end

exit
require 'dxruby'

hlsl = <<EOS
  float3 rgb;
  texture tex0;

  sampler Samp0 = sampler_state
  {
   Texture =<tex0>;
  };

  float4 PS(float2 input : TEXCOORD0) : COLOR0
  {
    float4 output;

    output = tex2D( Samp0, input );
    output.rgb = rgb;
    return output;
  }

  technique
  {
   pass
   {
    PixelShader = compile ps_2_0 PS();
   }
  }
EOS

core = Shader::Core.new(hlsl,{:rgb=>:float})
shader = Shader.new(core)

image = Image.new(100, 100).circle_fill(50, 50, 50, [111, 0, 255])

g = (Array 1..255).cycle
Window.loop do
  exit if Input.keyPush? K_F9
  shader.rgb = [0, 111,  222]
  Window.draw(50, 50, image)
  Window.draw_shader(200, 50, image, shader)
end



exit
require 'dxruby'

hlsl = <<EOS
  texture tex0;

  sampler Samp0 = sampler_state
  {  Texture =<tex0>; };

  float4 PS(float2 input : TEXCOORD0) : COLOR0
  {
    float4 output;

    output = tex2D( Samp0, input );
    return output;
  }

  technique Normal
  {
   pass P0
   {
    PixelShader = compile ps_2_0 PS();
   }
  }
EOS

core = Shader::Core.new(hlsl)
shader = Shader.new(core, "Normal")

image = Image.new(100, 100, [255, 222, 255])

Window.loop do
  exit if Input.keyPush? K_F9
  Window.draw(50, 50, image)
  Window.draw_shader(200, 50, image, shader)
end




exit
require "dxruby"




Window.lopp do
  exit if Input.keyPush? K_ESCAPE
  exit if Input.keyPush? K_F9


end
