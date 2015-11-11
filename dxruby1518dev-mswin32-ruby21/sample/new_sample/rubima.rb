#!ruby -Ks
# ���т܃T���v���Q�[��
require 'dxruby'

# �w�i�`��
class Map
  @@map = [[0, 0, 0, 0, 0, 0, 0, 0, 29, 11, 11, 30, 34, 66, 67, 67],
           [0, 0, 0, 24, 25, 26, 0, 0, 29, 11, 11, 39, 40, 6, 34, 34],
           [0, 0, 24, 17, 31, 35, 0, 0, 12, 20, 11, 11, 11, 39, 40, 40],
           [0, 24, 17, 34, 7, 44, 0, 28, 28, 29, 11, 11, 11, 11, 11, 11],
           [0, 33, 31, 34, 35, 0, 28, 3, 37, 38, 11, 11, 11, 18, 19, 19],
           [0, 42, 43, 43, 44, 28, 3, 38, 11, 11, 11, 18, 19, 13, 28, 28],
           [0, 0, 0, 0, 3, 37, 38, 11, 11, 18, 19, 13, 28, 28, 28, 0],
           [0, 0, 0, 3, 38, 11, 11, 11, 18, 13, 28, 28, 51, 52, 52, 52],
           [0, 0, 3, 38, 11, 11, 18, 19, 13, 51, 52, 52, 86, 58, 61, 76],
           [28, 0, 29, 11, 11, 18, 13, 28, 51, 86, 58, 58, 61, 61, 58, 62],
           [0, 28, 29, 11, 18, 13, 28, 0, 60, 58, 61, 61, 61, 61, 76, 71],
           [0, 28, 29, 11, 27, 28, 28, 51, 86, 61, 61, 58, 76, 70, 71, 0],
           [0, 0, 29, 11, 36, 4, 28, 60, 58, 61, 58, 76, 71, 0, 1, 2],
           [0, 28, 29, 11, 11, 36, 4, 69, 70, 70, 70, 71, 0, 1, 2, 0],
           [0, 0, 12, 20, 11, 11, 27, 0, 1, 0, 1, 1, 1, 2, 2, 0],
           [0, 0, 28, 12, 20, 11, 27, 0, 0, 0, 2, 2, 0, 2, 2, 0],
           [0, 0, 0, 2, 29, 11, 27, 1, 2, 2, 2, 0, 0, 2, 2, 2],
           [0, 0, 0, 2, 29, 11, 27, 1, 0, 1, 1, 2, 2, 0, 0, 2],
           [0, 0, 0, 0, 29, 11, 27, 1, 0, 2, 2, 2, 1, 1, 2, 2],
           [0, 45, 47, 2, 29, 11, 36, 4, 1, 2, 2, 0, 0, 2, 2, 0],
           [45, 82, 56, 0, 29, 11, 11, 36, 4, 1, 2, 2, 2, 2, 0, 0],
           [54, 0, 56, 0, 12, 20, 11, 11, 36, 37, 4, 0, 2, 2, 2, 2],
           [54, 55, 81, 46, 47, 12, 20, 11, 11, 11, 36, 4, 1, 1, 1, 2],
           [54, 55, 0, 0, 56, 0, 12, 19, 20, 11, 11, 36, 37, 4, 1, 1],
           [54, 0, 55, 55, 56, 0, 0, 0, 12, 20, 11, 11, 11, 36, 37, 37],
           [63, 73, 55, 55, 56, 0, 0, 2, 2, 29, 11, 11, 11, 11, 11, 11],
           [0, 54, 0, 55, 81, 47, 0, 2, 3, 38, 11, 11, 11, 11, 11, 11],
           [0, 54, 0, 0, 55, 56, 2, 0, 29, 11, 11, 11, 21, 22, 22, 22],
           [0, 63, 64, 64, 64, 65, 0, 0, 29, 11, 11, 21, 15, 48, 49, 49],
           [0, 0, 0, 0, 0, 0, 0, 0, 29, 11, 11, 30, 34, 57, 34, 34],
          ]
  temp = Image.load("image/maptile.png")
  x = temp.width / 32
  y = temp.height / 32
  @@images = temp.slice_tiles(x, y, true)

  # ������
  def initialize
    @y = 14 * 32    # �}�b�v�̏����ʒu
    @count = 0      # 1�`�b�v�Ԃ��ړ������t���[����
  end

  # �}�b�v�X�V
  def update
    @count -= 1
  end

  # �}�b�v�`��
  def draw
    $rt.draw_tile(0, 0, @@map, @@images, 0, @y + @count, 16, 16, 0)
  end
end

# �G�P�̂����ꏈ��
class Enemy1bomb < Sprite
  @@image0 = Image.load_tiles("image/enemy1bomb.png", 4, 2, true)
  @@image1 = @@image0.map {|image| image.flush([128, 0, 0, 0])}

  # �C���X�^���X������
  def initialize(x, y)
    super(x, y)
    self.z = 10
    self.target = $rt
    @count = 0
  end

  # �X�V
  def update
    self.y += 1.5
    @count += 1
    if @count >= 40
      self.vanish
    end
  end

  # �`��
  def draw
    self.image = @@image0[@count / 5]
    super
    $rt.draw(self.x-16, self.y-16, @@image1[@count / 5], 1)
  end
end

# �G�Q�̂����ꏈ��
class Enemy2bomb < Sprite
  @@image0 = Image.load_tiles("image/enemy2bomb.png", 4, 2, true)
  @@image1 = @@image0.map {|image| image.flush([128, 0, 0, 0])}

  # �C���X�^���X������
  def initialize(x, y)
    super(x, y)
    self.z = 10
    self.target = $rt
    @count = 0
  end

  # �X�V
  def update
    self.y += 0.5
    @count += 1
    if @count >= 40
      self.vanish
    end
  end

  # �`��
  def draw
    self.image = @@image0[@count / 5]
    super
    $rt.draw(self.x-16, self.y-16, @@image1[@count / 5], 1)
  end
end

# �G�P�p�V���b�g�q�b�g��
class EnemyShot1Hit < Sprite
  @@image = Image.load("image/enemyshot1.png")

  # �C���X�^���X������
  def initialize(x, y, angle)
    super(x, y, @@image)
    self.z = 20
    self.alpha = 255
    self.target = $rt
    temp2 = angle + 180
    @dx = Math.cos((temp2) / 180.0 * Math::PI)
    @dy = Math.sin((temp2) / 180.0 * Math::PI)
  end

  # �X�V
  def update
    self.x += @dx
    self.y += @dy
    self.alpha -= 10

    if self.alpha < 0
      self.vanish
    end
  end
end

# �G�P�p�V���b�g
class EnemyShot1 < Sprite
  @@image = Image.load("image/enemyshot1.png")
  @@sound = Array.new(3) do
    v = 60
    SoundEffect.new(60,WAVE_TRI) do
      v = v - 1
      [800, v]
    end
  end
  @@soundnumber = 0
  @@soundflag = false

  # �C���X�^���X������
  def initialize(x, y, angle)
    super(x, y, @@image)
    self.z = 20
    self.collision = [4, 4, 11, 11]
    self.target = $rt
    @dx = Math.cos(angle / 180.0 * Math::PI) * 1.5
    @dy = Math.sin(angle / 180.0 * Math::PI) * 1.5
    @shot_angle = angle
  end

  # �X�V
  def update
    self.x += @dx
    self.y += @dy
    @@soundflag = false
  end

  def shot(obj)
    self.vanish
    $etc_objects << EnemyShot1Hit.new(self.x, self.y, @shot_angle)
    if @@soundflag == false
      @@sound[@@soundnumber].play
      @@soundnumber += 1
      @@soundnumber = 0 if @@soundnumber > 2
      @@soundflag = true
    end
  end
end

# �G�Q�p�V���b�g�q�b�g��
class EnemyShot2Hit < Sprite
  @@image = Image.load("image/enemyshot2.png")

  # �C���X�^���X������
  def initialize(x, y, angle)
    super(x, y, @@image)
    self.z = 20
    self.alpha = 255    # �A���t�@�l
    self.target = $rt
    temp2 = angle + 180
    @dx = Math.cos((temp2) / 180.0 * Math::PI) * 3.5
    @dy = Math.sin((temp2) / 180.0 * Math::PI) * 3.5
  end

  # �X�V
  def update
    # �ړ�
    self.x += @dx
    self.y += @dy
    self.alpha -= 10
    if self.alpha < 0
      self.vanish
    end
  end
end

# �G�Q�p�V���b�g
class EnemyShot2 < Sprite
  @@image = Image.load("image/enemyshot2.png")
  v = 60
  @@sound = Array.new(3) do
    v = 60
    SoundEffect.new(60,WAVE_TRI) do
      v = v - 1
      [600, v]
    end
  end
  @@soundnumber = 0
  @@soundflag = false

  # �C���X�^���X������
  def initialize(x, y, angle)
    super(x, y, @@image)
    self.z = 20
    self.collision = [6, 6, 17, 17]
    self.target = $rt
    @dx = Math.cos(angle / 180.0 * Math::PI) * 3.5
    @dy = Math.sin(angle / 180.0 * Math::PI) * 3.5
    @shot_angle = angle
  end

  # �X�V
  def update
    # �ړ�
    self.x += @dx
    self.y += @dy
    @@soundflag = false
  end

  # ���@�ɓ��������Ƃ��ɌĂ΂��郁�\�b�h
  def shot(obj)
    self.vanish
    $etc_objects << EnemyShot2Hit.new(self.x, self.y, @shot_angle)
    if @@soundflag == false
      @@sound[@@soundnumber].play
      @@soundnumber += 1
      @@soundnumber = 0 if @@soundnumber > 2
      @@soundflag = true
    end
  end
end

# �G�P
class Enemy1 < Sprite
  # �摜�ǂݍ��݁��t���b�V��/�e�摜����
  image0 = Image.load_tiles("image/enemy1.png", 4, 1, true)  # �ǂݍ���
  image1 = image0.map {|image| image.flush([255, 200, 200, 200])}
  image2 = image0.map {|image| image.flush([128, 0, 0, 0])}
  @@image = [image0, image1, image2]

  # SoundEffect�ł��������ʉ������B�R�܂ł̑��d�Đ����ł����悤�z�񉻁B
  @@sound = Array.new(3) do
    v = 60
    f = 500
    SoundEffect.new(120,WAVE_SAW) do
      v = v - 0.5
      f = f - 1
      [f, v]
    end
  end
  @@soundnumber = 0
  @@soundflag = false

  # �C���X�^���X������
  def initialize(x, y)
    super(x, y)
    self.z = 10
    self.collision = [0, 0, 47, 47] # �Փ˔���
    self.target = $rt
    @hp = 15         # �q�b�g�|�C���g
    @shotcount = 0   # �e�����Ԋu�𑪂��J�E���^
    @imagenumber = 0 # ���e������1(�t���b�V�����\��)
    @animecount = 0  # �A�j���[�V�����p�J�E���^
  end

  # �X�V
  def update
    # �ړ�
    self.y += 2

    # �e��������
    @shotcount += 1
    if @shotcount > 40
      # �p�x�v�Z
      angle = (Math.atan2($myship.y + 16 - (self.y + 24 + 8), $myship.x + 16 - (self.x + 16 + 8)) / Math::PI * 180)

      # �e������
      $enemy_shots << EnemyShot1.new(self.x + 16, self.y + 24, angle)

      # �J�E���g������
      @shotcount = 0
    end

    # �Ƃ肠�����t���[���A�t���b�V�����Ă��Ȃ����Ԃɂ���
    @imagenumber = 0

    # �A�j���[�V�����p�J�E���g
    @animecount += 1
    @animecount -= 80 if @animecount >= 80

    @@soundflag = false
  end

  # ���@�V���b�g�ɓ��������Ƃ��ɌĂ΂��郁�\�b�h
  def hit(obj)
    # HP�����炷
    @hp = @hp - obj.damage

    # �����ꏈ��
    if @hp <= 0
      self.vanish
      $etc_objects << Enemy1bomb.new(self.x, self.y)

      # ���������ʉ��̑��d�Đ�
      if @@soundflag == false
        @@sound[@@soundnumber].play
        @@soundnumber += 1
        @@soundnumber = 0 if @@soundnumber > 2
        @@soundflag = true
      end
    end

    # �t���b�V�����ɂ���
    @imagenumber = 1
  end

  def draw
    self.image = @@image[@imagenumber][@animecount / 20]
    super
    $rt.draw(self.x-16, self.y-16, @@image[2][@animecount / 20], 1)
  end
end

# �G�Q
class Enemy2 < Sprite
  # �摜�ǂݍ��݁��t���b�V��/�e�摜����
  image0 = Image.load_tiles("image/enemy2.png", 4, 1, true)  # �ǂݍ���
  image1 = image0.map {|image| image.flush([255, 200, 200, 200])}
  image2 = image0.map {|image| image.flush([128, 0, 0, 0])}
  @@image = [image0, image1, image2]
  v = 80
  @@sound = SoundEffect.new(4000,WAVE_RECT, 5000) do
    v = v - 0.03
    [rand(300), v]
  end

  # �C���X�^���X������
  def initialize(x, y)
    super(x, y)
    self.z = 10
    self.collision = [0, 0, 127, 63] # �Փ˔���
    self.target = $rt
    @dy = 10 # �c�ړ���
    @hp = 400 # �q�b�g�|�C���g
    @shotcount = 0   # �e�����Ԋu�𑪂��J�E���^
    @imagenumber = 0 # ���e������1(�t���b�V�����\��)
    @animecount = 0  # �A�j���[�V�����p�J�E���^
  end

  # �X�V
  def update
    # �ړ�
    self.y += @dy

    if @dy > 0         # ���Ɉړ���
      @dy -= 0.3         # ����
    else               # �ړ��������Ă�����
      @shotcount += 1    # �V���b�g�J�E���g�𑫂���
      if @shotcount > 60 # �J�E���g��60�𒴂������e������
        # �p�x�v�Z
        angle = (Math.atan2($myship.y + 16 - (self.y + 40 + 12), $myship.x + 16 - (self.x + 56 + 12)) / Math::PI * 180)
        # 5������
        $enemy_shots << EnemyShot2.new(self.x + 56, self.y + 40, angle - 45)
        $enemy_shots << EnemyShot2.new(self.x + 56, self.y + 40, angle - 22.5)
        $enemy_shots << EnemyShot2.new(self.x + 56, self.y + 40, angle)
        $enemy_shots << EnemyShot2.new(self.x + 56, self.y + 40, angle + 22.5)
        $enemy_shots << EnemyShot2.new(self.x + 56, self.y + 40, angle + 45)
        # �J�E���g������
        @shotcount = 0
      end
    end

    # �Ƃ肠�����t���[���A�t���b�V�����Ă��Ȃ����Ԃɂ���
    @imagenumber = 0

    # �A�j���[�V�����p�J�E���g
    @animecount += 1
    @animecount -= 40 if @animecount >= 40
  end

  # ���@�V���b�g�����������Ƃ��ɌĂ΂��郁�\�b�h
  def hit(obj)
    # HP�����炷
    @hp = @hp - obj.damage

    # �����ꏈ��
    if @hp <= 0
      self.vanish
      $etc_objects << Enemy2bomb.new(self.x, self.y)
      @@sound.play
    end

    # �t���b�V�����ɂ���
    @imagenumber = 1
  end

  # �`��
  def draw
    self.image = @@image[@imagenumber][@animecount / 10]
    super
    $rt.draw(self.x-16, self.y-16, @@image[2][@animecount / 10], 1)       # �e
  end
end

# ���@�p�V���b�g
class MyShot < Sprite
  @@image = Image.load("image/myshot.png")
  attr_accessor :damage

  # �C���X�^���X������
  def initialize(x, y, angle)
    super(x, y, @@image)
    self.z = 15
    self.collision = [0, 0, 31, 31] # �Փ˔���
    self.angle = angle + 90 # �p�x
    self.target = $rt
    @dx = Math.cos(angle / 180.0 * Math::PI) * 16 # ���ړ���
    @dy = Math.sin(angle / 180.0 * Math::PI) * 16 # �c�ړ���
    @damage = 5     # �G�ɓ��������Ƃ��ɗ^�����_���[�W
  end

  # �X�V
  def update
    # �V���b�g�ړ�
    self.x += @dx
    self.y += @dy
  end

  # �G�ɓ��������Ƃ��ɌĂ΂��郁�\�b�h
  def shot(obj)
    self.vanish
  end
end

# ���@
class MyShip < Sprite

  # �摜�ǂݍ��݂Ɖe�摜����
  @@image0 = Image.load_tiles("image/myship.png", 4, 1, true)
  @@image1 = @@image0.map {|image| image.flush([128, 0, 0, 0])}

  # �V���b�g������
  f = 4000
  @@sound = SoundEffect.new(20, WAVE_TRI) do   # 20ms �̎O�p�g�𐶐�����
    f = f - 120      # ���g���� 4000Hz ���� 1ms ���Ƃ� 120Hz ������
    [f, 15]          # [ ���g��, ���� ] �̔z�����Ԃ�
  end

  # ����������
  def initialize
    super(200, 400)
    self.z = 15
    self.collision = [4, 4, 27, 27]  # �Փ˔���
    self.target = $rt
    @animecount = 0   # �A�j���[�V�����p�J�E���g

  end

  def update
    # �ړ�
    dx = Input.x * 3
    dy = Input.y * 3
    if Input.x != 0 and Input.y != 0   # �i�i���̎��� 0.7 �{
      dx *= 0.7
      dy *= 0.7
    end
    self.x += dx
    self.y += dy

    # ���ʒ[�̔���
    self.x = 0 if self.x < 0
    self.x = 448 - 32 if self.x > 448 - 32
    self.y = 0 if self.y < 0
    self.y = 480 - 32 if self.y > 480 - 32

    # �V���b�g
    if Input.pad_push?(P_BUTTON0)
      $my_shots << MyShot.new(self.x - 18, self.y - 32, 270)
      $my_shots << MyShot.new(self.x + 18, self.y - 32, 270)
      $my_shots << MyShot.new(self.x + 32, self.y - 16, 300)
      $my_shots << MyShot.new(self.x - 32, self.y - 16, 240)
      @@sound.play
    end

    # �A�j���[�V�����p�J�E���g
    @animecount += 1
    @animecount -= 80 if @animecount >= 80
  end

  # �`��
  def draw
    self.image = @@image0[@animecount / 20]
    super
    $rt.draw(self.x - 16, self.y - 16, @@image1[@animecount / 20], 1)  # �e
  end
end

# �������܂ł��N���X���`

# ���������炪�Q�[���̃��C������

Window.caption = "���тܗp�T���v���Q�[����DXRuby1.4��" # �E�B���h�E�̃L���v�V�����ݒ�
Window.width = 360        # �E�B���h�E�̉��T�C�Y�ݒ�
Window.height = 480       # �E�B���h�E�̏c�T�C�Y�ݒ�
Input.set_repeat(0, 5)     # �L�[�̃I�[�g���s�[�g�ݒ��B5 �t���[���� 1 �� on

$etc_objects = []          # �I�u�W�F�N�g�z��
$my_shots = []              # �e
$enemies = []              # �G
$enemy_shots = []          # �G�̒e

$rt = RenderTarget.new(448,480)
screen_sprite = Sprite.new(0, 0)
screen_sprite.collision = [0, 0, 448, 480]

count = 0                 # �G�o�������p�J�E���g
font = Font.new(32)       # �t�H���g����

$myship = MyShip.new      # ���@����
$etc_objects << $myship  # ���@���I�u�W�F�N�g�z���ɒǉ�
$etc_objects << Map.new  # �w�i�I�u�W�F�N�g�������I�u�W�F�N�g�z���ɒǉ�

# ���C�����[�v
Window.loop do

  # �G�o������
  count += 1
  if count % 20 == 0      #  20 �J�E���g�� 1 ��
    if count % 400 == 0   # 400 �J�E���g�� 1 ��
      # �G 2 �̃I�u�W�F�N�g�������I�u�W�F�N�g�z���ɒǉ�
      $enemies << Enemy2.new(rand(240), -64)
      count = 0
    else
      # �G 1 �̃I�u�W�F�N�g�������I�u�W�F�N�g�z���ɒǉ�
      $enemies << Enemy1.new(rand(320), -48)
    end
  end

  # �I�u�W�F�N�g�����X�V
  Sprite.update([$etc_objects, $my_shots, $enemies, $enemy_shots])

  # ���ʂ����o����������
  $my_shots = screen_sprite.check($my_shots)
  $enemies = screen_sprite.check($enemies)
  $enemy_shots = screen_sprite.check($enemy_shots)

  # �Փ˔���
  Sprite.check($my_shots, $enemies)     # ���@�V���b�g�ƓG
  Sprite.check($enemy_shots, $myship)   # �G�V���b�g�Ǝ��@

  # �Փ˔����ŏ������L�������z�񂩂��폜
  Sprite.clean([$etc_objects, $my_shots, $enemies, $enemy_shots])

  # �I�u�W�F�N�g���`��
  Sprite.draw([$etc_objects, $my_shots, $enemies, $enemy_shots])

  $rt.update
  Window.draw(-$myship.x/5,0,$rt)

  # Esc �L�[�ŏI��
  break if Input.key_push?(K_ESCAPE)

  # �e�������o��
  Window.draw_font(0, 0, Window.get_load.to_i.to_s + " %", font, :z => 100)
  Window.draw_font(0, 32, [$etc_objects, $my_shots, $enemies, $enemy_shots].flatten.size.to_s + " objects", font, :z => 100)
end
