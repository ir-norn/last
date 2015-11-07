#!ruby -Ks
require "dxruby"

class Ruby < Sprite
  RT = RenderTarget.new(640,480)
  MAX_X = 639 - 32
  MAX_Y = 479 - 32

  # Image�I�u�W�F�N�g���쐬
  @@image = Image.load("ruby.png")

  # ���������\�b�h
  def initialize
    super
    self.x = rand(MAX_X)+1 # x���W
    self.y = rand(MAX_Y)+1 # y���W
    self.image = @@image  # �摜
    self.target = RT      # �`����

    @dx = rand(2) * 2 - 1 # x����
    @dy = rand(2) * 2 - 1 # y����
  end

  # �X�V
  def update
    self.x += @dx
    self.y += @dy
    if self.x <= 0 or MAX_X <= self.x
      @dx = -@dx
    end
    if self.y <= 0 or MAX_Y <= self.y
      @dy = -@dy
    end
  end
end

# Sprite �I�u�W�F�N�g�̔z���𐶐������B
sprites = Array.new(1000){ Ruby.new }

font = Font.new(32)

# �E�B���h�E�̃L���v�V�������ݒ肷���B
Window.caption = "Sprites"

# fps���ݒ肷���B
Window.fps = 60

# ���C�����[�v�B
# �E�B���h�E�������ꂽ�ꍇ�͎����I�ɏI�������B
# ���ʂ͖��t���[�����Z�b�g�������B
Window.loop do
  # ESC �L�[�������ꂽ�ꍇ�I�������B
  break if Input.keyPush?(K_ESCAPE)

  Sprite.update(sprites)
  Sprite.draw(sprites)

  Ruby::RT.update
  Window.draw(0,0,Ruby::RT)

  Window.drawFont(0,0,Window.fps.to_s + " fps", font)
  Window.drawFont(0,40,sprites.size.to_s + " objects", font)
  Window.drawFont(0,80,Window.getLoad.to_i.to_s + " %", font)
end
