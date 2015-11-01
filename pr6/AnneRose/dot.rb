#!ruby -Ks
# DXRuby �T���v�� ��
# �}�E�X���N���b�N�ŕ`���āA�E�N���b�N�ŏ����܂��B
require 'dxruby'

# �E�B���h�E�ݒ�


# ���ʂ̉摜�f�[�^
$screen = Image.new(160, 120)

BLACK = [0, 0, 0]
WHITE = [255, 255, 255]

class Dot
  def initialize(x, y)
    @x = x
    @y = y
  end

  # �������̂��߂ɓ_���ړ������Ƃ��̂ݕ`�悷���悤�ɂ����炿�����Ƃ����Ⴒ����
  def move
    if $screen.compare(@x, @y + 1, BLACK) then # �^��
      $screen[@x, @y] = BLACK
      @y = @y + 1
      return true if @y > 119
      $screen[@x, @y] = WHITE
    elsif rand(2) == 0 then
      if $screen.compare(@x-1, @y + 1, BLACK) then # ����
        $screen[@x, @y] = BLACK
        @y = @y + 1
        @x = @x - 1
        return true if @y > 119
        $screen[@x, @y] = WHITE
      end
    else
      if $screen.compare(@x+1, @y + 1, BLACK) then # �E��
        $screen[@x, @y] = BLACK
        @y = @y + 1
        @x = @x + 1
        return true if @y > 119
        $screen[@x, @y] = WHITE
      end
    end
    return false
  end
end

dot = []

Window.loop do
  # �h�b�g����
  dot.push(Dot.new(rand(10)+75, 0))

  # �}�E�X�̍��W�擾
  mx = Input.mousePosX / 2
  my = Input.mousePosY / 2

  # ���N���b�N�ŕ`��
  if Input.mouseDown?(M_LBUTTON) then
    $screen.boxFill(mx - 1, my - 1, mx + 1, my + 1, [0, 255, 0])
  end

  # �E�N���b�N�ŏ���
  if Input.mouseDown?(M_RBUTTON) then
    $screen.boxFill(mx - 1, my - 1, mx + 1, my + 1, [0, 0, 0])
  end

  # �h�b�g�ړ�
  dot.delete_if do |d|
    d.move
  end

  # ���ʕ`��
  Window.draw(0, 0, $screen)

  break if Input.keyPush?(K_ESCAPE)
end
