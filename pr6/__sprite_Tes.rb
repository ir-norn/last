require 'dxruby'

sprites = []
image = Image.new(64, 64).box(0, 0, 63, 63,[255, 255, 255])
for i in 0..7
  for j in 0..9
    sprites << Sprite.new(j * 64, i * 64, image)
  end
end

image_select = Image.new(64, 64, [128, 255, 255, 255])
sprite_mouse = Sprite.new
sprite_mouse.collision = [0, 0]

Window.loop do
  sprite_mouse.x, sprite_mouse.y = Input.mouse_pos_x, Input.mouse_pos_y

  temp = sprite_mouse.check(sprites) # 衝突チェック

  if temp # 当たっていれば配列が返る
    temp.each do |s|
      Window.draw(s.x, s.y, image_select)
    end
  end

  sprites.each do |s|
    s.draw
  end
end
