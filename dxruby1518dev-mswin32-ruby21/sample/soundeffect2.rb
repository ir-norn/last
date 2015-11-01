require 'dxruby'

se = SoundEffect.new(1000, WAVE_SIN) {[440,40]}
se.add(WAVE_SIN) {[442,40]}

ary = se.to_a

Window.loop do
  640.times do |i|
    Window.draw_line(i, 240, i, ary[i * ary.size / 640] * 240.0 + 240, C_WHITE)
  end
  se.play if Input.key_push?(K_Z)
  break if Input.key_push?(K_ESCAPE)
end
