DXRuby1.5.18dev

���P�D�͂��߂�

 DXRuby1.5�n�͊J���łł��B �傫�ȐV�@�\�͂���܂��񂪁A�R�}�S�}�Ƃ����@�\�ǉ��ƁA��Օ����ւ̏C���������Ă��܂��B
 �����łɎ�荞�܂�Ă��Ȃ��d�l�͖��m��ŁA����\�������ύX�����\��������܂��B
 ���������΃}�j���A���ɏ����Y��Ă������ۂ��̂ł����ADXRuby::VERSION�Ńo�[�W�������擾�ł��܂��B


���Q�DDXRuby1.4.1����傫���ς�����Ƃ���

 Vector/Matrix�N���X���ǉ�����܂����B
 �e�N���X/���W���[���ɂ��낢��ȃ��\�b�h���ǉ�����܂����B
 Input::IME���W���[���ɂ����{����͂��ł���悤�ɂȂ�܂����B
 Window.loop�������u����悤�ɂȂ�܂����B
 �����̂قƂ�ǂ�UNICODE�����܂����B
 �f�t�H���g�A�C�R�����ݒ肳��܂����B

���Q-1. DXRuby1.5.17dev����ς�����Ƃ���

 Sprite�̏Փ˔���܂��̃������o�O���C���ƃp�t�H�[�}���X���P�B
 �Փ˔���̔z����l�X�g�ł���悤�C���B
 Sprite#visible��false�̃I�u�W�F�N�g�͏Փ˔��菈��������Ȃ��悤�C���B
 Input���W���[���̒萔�̕ύX�̎������B
 Input.push?/down?/release?�폜�B


���R�D����

 �o�O�����邩������܂���̂Ŏg���Ă݂ė\�z�O�̓����������畷���Ă��������B


���S�DDXRuby1.4.1����̍������t�@�����X&�C���_

���S-1.Window���W���[��

Window.loop( close_cancel = nil ) -> nil

 ����ł��u����悤�ɂȂ�܂����B
 ������close_cancel��true�ɂ���ƃ��[�U�̕��鑀��𖳎�����悤�ɂȂ�܂��B���鑀�삪���ꂽ�ꍇ�AInput.update��������Input.requested_close?��true���Ԃ��Ă���̂ŁA������`�F�b�N���Ď�����break����Ȃ肭�������B

Window.close/closed?/created?

 close�̓E�B���h�E����܂��Bclosed?�͕����Ă�����true�Acreated?�͕\������Ă�����true��Ԃ��܂��B

Window.full_screen/full_screen?

 Window.windowed/windowed?�̋t�ł��B


���S-2�DWindow/RenderTarget����

Window.draw_text/draw_text_ex/draw_tiles
RenderTarget#draw_text/draw_text_ex/draw_tiles

 ���ꂼ��Adraw_font/draw_font_ex/draw_tile��alias�ł��B


���S-3. Font�N���X

Font#name

 ���ۂɐ������ꂽ�t�H���g�����Ԃ�܂��B�t�H���g�𐶐�����ۂɗ^�������̂�����������ȗ������ꍇ�ɁA�����������ꂽ����m�邱�Ƃ��ł��܂��BFont#fontname�͎w�肵�����̂��Ԃ�܂��B


���S-4. Sprite�N���X

 Sprite#visible��false�̃I�u�W�F�N�g��Sprite#collision_enable��true�ł��Փ˂��Ȃ��Ȃ�܂����B

Sprite#xy -> Vector
Sprite#xy=( v ) -> v

 2�v�f��Vector�I�u�W�F�N�g��xy�𓯎��Ɏ擾�E�ݒ肵�܂��B
 Sprite#xy=��3�v�f��Vector�I�u�W�F�N�g��n���Ǝn�߂�2�v�f�̂ݎg���܂��̂�[x, y, 1]�Ƃ����`����Vector�ł��ݒ肷�邱�Ƃ��ł��܂��B3�v�fVector���w�肵�Ă����̃��\�b�h�ł�z�͍X�V����܂���B

Sprite#xyz -> Vector
Sprite#xyz=( v ) -> v

 3�v�f��Vector�I�u�W�F�N�g��xyz�𓯎��Ɏ擾�E�ݒ肵�܂��Bz�͕`��D�揇�ʂɎg���܂��B
 Sprite#xyz=��4�v�f��Vector�I�u�W�F�N�g��n���Ǝn�߂�3�v�f�̂ݎg���܂��̂�[x, y, z, 1]�Ƃ����`����Vector�ł��ݒ肷�邱�Ƃ��ł��܂��B

Sprite.check

 �R�[���o�b�N���\�b�hhit/shot�Ɉ����������Ă��G���[�ɂȂ�Ȃ��Ȃ�܂����B

Sprite.render/Sprite#render

 ���ꂼ��draw��alias�ł��BSprite.render�͓n���ꂽ�z����̃I�u�W�F�N�g��render���Ăяo���܂��B


���S-5. Input���W���[��

 �p�b�h�{�^���ƃ}�E�X�{�^���萔�̒�`�l���啝�ɕύX����܂����B
 ���萔�̒�`�l�͌��ɖ߂�܂����B���ꃁ�\�b�hInput.push?/down?/release?���폜����܂����B

Input.requested_close? -> true/false

 Window.loop��true��n�����ꍇ�ɁA���[�U�����悤�Ƃ��Ă�����true���Ԃ�܂��B

Input.mouse_x/mouse_y

 ���ꂼ��mouse_pos_x/mouse_pos_y��alias�ł��B


���S-5b. Input::IME���W���[��

Input::IME.enable=(v) -> v
Input::IME.enabled?

 IME��ON/OFF��true/false�Őݒ肵�܂��B�f�t�H���g��false�ł��B
 true�ɂ���ƑS�p/���p�L�[��IME��L���ɂł���悤�ɂȂ�܂��B

Input::IME.get_string -> String

 IME����n���ꂽ�������Ԃ��܂��B�ϊ����̕�����͉�ʂɂ͕\������܂����n���ꂸ�A�m�莞�ɓn����܂��B
 �����R�[�h��Windows�Ȃ̂�Windows-31J�ƂȂ�܂��BUTF-8�������l�̓G���R�[�h�ϊ����Ă��������B
 ���̃��\�b�h�ŕԂ��Ă��镶����͑O�t���[�����獡�t���[���܂ł̊Ԃɓ��͂��ꂽ�����݂̂ł��B�t���[���𒴂��ăo�b�t�@����邱�Ƃ͂���܂���B���񎩓��I�ɃN���A�����̂Ńo�b�t�@�N���A���\�b�h������܂���B
 DXRuby�v���O���~���O�ɂ����āA�o�b�t�@�͎擾���Ȃ����Ǔ��͓��e�͎c���Ă����Ăق����t���[�������邱�Ƃ�z�肵�Ă��Ȃ�����Ȃ̂ł����A������҂̑z��͈͊O�ŗL�p�Ȏg�����̃A�C�f�A���������̂����͂��Ћ����Ă��������B�������ƍ��܂��B
 �܂��A���̃��\�b�h�ł͐���R�[�h�͕Ԃ��Ă��܂���B�����������L�[��Input::IME.push_keys���g���Ĕ��肵�Ă��������B
 �Ԃ��Ă��镶����́A�ϊ�����UNICODE�ˑ����������݂��Ă���s����UTF-8�Œ�ƂȂ�܂��B

Input::IME.compositing? -> true/false

 IME���͒����ǂ�����true/false�ŕԂ��܂��B�J�[�\���̈ړ��Ȃǂ�Input.key_push?�ŏ������Ă���ꍇ�AIME���͒��ł��󂯎��Ă��܂��̂ŁA�J�[�\���ړ���IME��ƃA�v����œ����ɔ������Ă��܂��܂��B���������ꍇ�͂��̃��\�b�h�œ��͒��𔻒肵�ăJ�[�\���ړ��Ȃǂ̏������Ȃ��܂��B

Input::IME.push_keys -> Array
Input::IME.release_keys -> Array

 �O�t���[�����獡�t���[���܂ł̊Ԃɉ����ꂽ�L�[/�����ꂽ�L�[�̒萔���z��Ɋi�[����ĕԂ��Ă��܂��BIME�ɉ���肳�ꂽ�L�[�͊i�[����܂���̂ŁA�������͂������ꍇ�̓���L�[����Ɏg���܂��B
 �V�X�e���̃I�[�g���s�[�g�����f����܂��B�I�[�g���s�[�g����push_keys�ɒl���A�����ē����Ă��܂����Arelease_keys�ɂ̓L�[���������܂œ����Ă��܂���B

Input::IME.get_comp_info -> Struct

 �ϊ����̊e������擾���܂��BStruct�I�u�W�F�N�g��Ԃ��܂��B
 ���̍\���̂ɂ͈ȉ��̏�񂪊i�[����Ă��܂��B
comp_str...�ϊ����̕�����S�̂ł��B
comp_attr...�ϊ����̈ꕶ���P�ʂő����̒l���i�[���ꂽ�z��ł��B
cursor_pos...�ϊ����̃J�[�\���ʒu�ł��B
can_list...�ϊ����(candidate)�̕����񂪊i�[���ꂽ�z��ł��B�\�������ׂ��͈݂͂̂��i�[����܂��B
selection...can_list�̂����A�I������Ă������index�ł��B
selection_total...�ϊ����S��(total�̒l)�̂����A���Ԗڂ��I�𒆂���\���܂��B
page_size...��x�ɕ\�������ׂ���␔��\���܂��B
total...�ϊ����S�̂̐���\���܂��B

comp_attr�Ɋi�[�����l�͈ȉ���4��ނŁA�萔�Ƃ��Ē�`����Ă��܂��B
Input::IME::ATTR_INPUT...���͒� 
Input::IME::ATTR_TARGET_CONVERTED...�I������Ăĕϊ�����Ă�
Input::IME::ATTR_CONVERTED...�I������ĂȂ��ĕϊ�����Ă�
Input::IME::ATTR_TARGET_NOTCONVERTED...�I������Ăĕϊ�����ĂȂ�

 �ϊ����̑S�̂̐���total�Ŏ擾�ł��܂����A�擾�ł��镶����͕\�������ׂ��y�[�W�͈݂̔͂̂ł��B�S�̂̕�����͎擾�ł��܂���B���Ă�������ł����A�K�v�Ȃ����ȁ[�ƁB
 ���̑I����y�[�W�؂�ւ��Ȃǂ�IME���ŏ�������Ă��܂��̂ŁARuby���Ő��䂷��K�v�͂���܂���B
 �Ԃ��Ă��镶����́A�ϊ�����UNICODE�ˑ����������݂��Ă���s����UTF-8�Œ�ƂȂ�܂��B
 �ȂɂԂ��₱�����@�\�Ȃ̂Ŏg���ɂ����Ƃ��������Ǝv���܂����A���̂����߂ĂȂ̂Ŏ���Ȃ��Ƃ���͂���͂��ł��B�����v�]�̓r�V�o�V�ǂ����B


���S-6. Matrix�N���X

Matrix.new( m = nil ) -> Matrix

 Matrix�I�u�W�F�N�g�𐶐����܂��B
 �������ȗ������4x4�v�f�̒P�ʍs���Ԃ��܂��B
 v�͔z��ŁA[[x1,y1,z1,w1],[x2,y2,z2,w2],[x3,y3,z3,w3],[x4,y4,z4,w4]]�Ƃ����`���œn����4x4�v�f�̍s�񂪍���܂��B
 ���l��3x3�A2x2�A1x1(?)�̍s��𐶐����邱�Ƃ��ł��܂��B
 �Q�[���p�Ȃ̂Ő����s�񂵂������܂���B

Martix.rotation( angle ) -> Matrix

 3x3�T�C�Y��z����]�s���Ԃ��܂��B2D��Vector���W����]����̂Ɏg���܂��B

Martix.rotation_x( angle ) -> Matrix

 4x4�T�C�Y��x����]�s���Ԃ��܂��B3D��Vector���W����]����̂Ɏg���܂��B

Martix.rotation_y( angle ) -> Matrix

 4x4�T�C�Y��y����]�s���Ԃ��܂��B3D��Vector���W����]����̂Ɏg���܂��B

Martix.rotation_z( angle ) -> Matrix

 4x4�T�C�Y��z����]�s���Ԃ��܂��B3D��Vector���W����]����̂Ɏg���܂��B

Martix.scaling(sx, sy = nil, sz = nil) -> Matrix

 �X�P�[�����O�s���Ԃ��܂��B�����͔{�����w�肵�܂��B
 �������w�肵����+1�T�C�Y�̍s���Ԃ��܂��B

Martix.translation(tx, ty = nil, tz = nil) -> Matrix

 �ړ��s���Ԃ��܂��B�����͈ړ��ʂ��w�肵�܂��B
 �������w�肵����+1�T�C�Y�̍s���Ԃ��܂��B

Martix.look_at( eye, at, up ) -> Matrix

 3D�̃r���[�s���Ԃ��܂��B
 eye�̓J�����ʒu���W��3�v�fVector�Aat�͉�ʂ̒��S�ɂ�����W��3�v�fVector�Aup�̓J�����̏������\��3�v�fVector���w�肵�܂��B
 �Ԃ��Ă���s���eye�̈ʒu����at�̕���������up��������ɂȂ�r���[�s��ł��B

Martix.projection( width, height, zn, zf ) -> Matrix

 3D�̎ˉe�ϊ��s���Ԃ��܂��B
 ��ʂ̕��A�����Azn�Azf���w�肵�܂��B

Martix.projection_fov( fov, aspect, zn, zf ) -> Matrix

 3D�̎ˉe�ϊ��s���Ԃ��܂��B
 ����p�A�c/���̃A�X�y�N�g��Azn�Azf���w�肵�܂��B

Martix#*( m ) -> Matrix

 self�̂ƈ�����Matrix�I�u�W�F�N�g�Ƃ̐ς�Ԃ��܂��B

Martix#to_s -> String

 self�𕶎��񉻂��܂��B

Martix#to_a -> Array

 self��z�񉻂��܂��B

Matrix#inverse -> Matrix

 self�̋t�s��𐶐����܂��B


���S-7. Vector�N���X

Vector.new( x, y = nil, z = nil, w = nil ) -> Vector

 Vector�I�u�W�F�N�g�𐶐����܂��B
 �w�肵���������̗v�f��������Vector�I�u�W�F�N�g�ƂȂ�܂��B

Vector.distance( v1, v2 ) -> Float

 2��Vector�I�u�W�F�N�g�̋������v�Z���ĕԂ��܂��B

Vector.cross_product( v1, v2 ) -> Vector

 2��Vector�I�u�W�F�N�g�̊O�ς��v�Z���A���ʂ�Vector�I�u�W�F�N�g�𐶐����ĕԂ��܂��B

Vector.dot_product( v1, v2 ) -> Float

 2��Vector�I�u�W�F�N�g�̓��ς�Ԃ��܂��B

Vector#*( v ) -> Vector

 self�ɑ΂���v���|���Z���A���ʂ�Vector�I�u�W�F�N�g�𐶐����ĕԂ��܂��B
 �����Ƃ��ėL���Ȃ̂�Fixnum/Float�Ȃǂ̐��l�I�u�W�F�N�g�AVector�I�u�W�F�N�g�AMatrix�I�u�W�F�N�g�ł��B
 Vector�I�u�W�F�N�g���w�肵���ꍇ�A���ςł͂Ȃ��A���ꂼ��̍��ړ��m�̐ς�����Vector�I�u�W�F�N�g�ɂȂ�܂��B

Vector#+( v ) -> Vector

 self�ɑ΂���v�����Z���A���ʂ�Vector�I�u�W�F�N�g�𐶐����ĕԂ��܂��B
 �����Ƃ��ėL���Ȃ̂�Fixnum/Float�Ȃǂ̐��l�I�u�W�F�N�g�AVector�I�u�W�F�N�g�ł��B

Vector#-( v ) -> Vector

 self�ɑ΂���v�����Z���A���ʂ�Vector�I�u�W�F�N�g�𐶐����ĕԂ��܂��B
 �����Ƃ��ėL���Ȃ̂�Fixnum/Float�Ȃǂ̐��l�I�u�W�F�N�g�AVector�I�u�W�F�N�g�ł��B

Vector#-@ -> Vector

 self�ɑ΂��ĕ������t�]����Vector�I�u�W�F�N�g�𐶐����ĕԂ��܂��B

Vector#/( v ) -> Vector

 self�ɑ΂���v�����Z���A���ʂ�Vector�I�u�W�F�N�g�𐶐����ĕԂ��܂��B
 �����Ƃ��ėL���Ȃ̂�Fixnum/Float�Ȃǂ̐��l�I�u�W�F�N�g�AVector�I�u�W�F�N�g�ł��B

Vector#to_s -> String

 self�𕶎��񉻂��܂��B

Vector#to_a -> Array

 self��z�񉻂��܂��B

Vector#x -> Float

 self�̑�1�v�f��Ԃ��܂��B

Vector#y -> Float

 self�̑�2�v�f��Ԃ��܂��B

Vector#z -> Float

 self�̑�3�v�f��Ԃ��܂��B

Vector#w -> Float

 self�̑�4�v�f��Ԃ��܂��B

Vector#xy -> Vector

 self�̑�1�A��2�v�f�݂̂𔲂��o����Vector�I�u�W�F�N�g��Ԃ��܂��B

Vector#xyz -> Vector

 self�̑�1�A��2�A��3�v�f�݂̂𔲂��o����Vector�I�u�W�F�N�g��Ԃ��܂��B

Vector#size -> Fixnum

 self�̗v�f����Ԃ��܂��B

Vector#normalize -> Vector

 ���K������Vector�I�u�W�F�N�g��Ԃ��܂��B

Vector#==( v ) -> true/false

 self�ƈ�����Vector�I�u�W�F�N�g�̓��e���r���܂��B

Vector#translate(x, y = nil, z = nil, w = nil) -> Vector

 self�̗v�f�ɂ��ꂼ��̈��������Z���A���ʂ�Vector�I�u�W�F�N�g�𐶐����ĕԂ��܂��B

Vector#rotate( angle, center_x=0, center_y=0 ) -> Vector

 self��z����]���A���ʂ�Vector�I�u�W�F�N�g��Ԃ��܂��B2DVector�p�ł��B
 center_x/center_y�ŉ�]���S���w��ł��܂��B

Vector#rotate_x( angle ) -> Vector

 self��x����]���A���ʂ�Vector�I�u�W�F�N�g��Ԃ��܂��B3DVector�p�ł��B

Vector#rotate_y( angle ) -> Vector

 self��y����]���A���ʂ�Vector�I�u�W�F�N�g��Ԃ��܂��B3DVector�p�ł��B

Vector#rotate_z( angle ) -> Vector

 self��z����]���A���ʂ�Vector�I�u�W�F�N�g��Ԃ��܂��B3DVector�p�ł��B

Vector#angle_to( v ) -> Float

 self����v�Ɍ������p�x��360�x�n�ŕԂ��܂��B


���S-8. Sound�N���X

Sound.load_from_memory( string ) -> Sound

 String�I�u�W�F�N�g�Ńt�@�C���f�[�^��n����Sound�I�u�W�F�N�g�𐶐��ł��܂��B

Sound#pan/pan=(v)

 �p���̎擾�E�ݒ肪�ł��܂��B�l��-10000����+10000�܂ŁA���E�̉���dB����\���܂��B

Sound#frequency/frequency=(v)

 ���g���̎擾�E�ݒ肪�ł��܂��B


���T. Ayame����

 ���̊J���łɂ̓T�E���h�h���C�oAyame�������g�����C�u�����̃e�X�g��Ayame/Ruby0.0.3�𓯍����Ă��܂��B
 mp3�Aogg�Amidi�Awav�̊e�t�@�C���������A�t�F�[�h�C��/�A�E�g�Ȃǂ��T�|�[�g���Ă��܂��B
 ����������Ђ��������������B


���U�D���C�Z���X

 zlib/libpng���C�Z���X��K�p���܂��B
 �������Ă���T���v���̓p�u���b�N�h���C���Ƃ��܂��B


���V�D�X�V����
2015/04/25 1.5.18dev Sprite�̏Փ˔���܂��̃������o�O���C���ƃp�t�H�[�}���X���P�B
                     �Փ˔���̔z����l�X�g�ł���悤�C���B
                     Sprite#visible��false�̃I�u�W�F�N�g�͏Փ˔��菈��������Ȃ��悤�C���B
                     Input���W���[���̒萔�̕ύX�̎������B
                     Input.push?/down?/release?�폜�B
2014/12/23 1.5.17dev Window.loop�������u����悤�ɂȂ�܂����B
                     Input�̃L�[�萔�l�ύX
                     �f�t�H���g�A�C�R����ݒ�
                     ����UNICODE���ŕ\���ł��Ȃ������������\���ł���悤�ɂȂ�܂����B
                     Window.close/closed?/created?�ǉ�
                     Sprite#param_hash�̃L�[�ύX(scalex��scale_x�Ȃ�)
                     font#name�ǉ�
                     Window/RenderTarget��draw_text/draw_text_ex/draw_tiles/full_screen/full_screen?�ǉ�
                     Sprite.render�ASprite#render�ǉ�
                     Sprite.check�̃R�[���o�b�N���\�b�h�Ɉ����������Ă������悤�ɂ��܂����B
                     Image#change_hls�̐F�v�Z�o�O�C��
                     Input.push?/down?/release?�ǉ�
                     Window.loop�Ɉ���close_cancel�ǉ�
                     Sound#pan/pan=/frequency/frequency=�ǉ�
                     Sound.load_from_memory�ǉ�
                     Vector#rotate�ɒ��S�_�̎w���ǉ�
                     Vector#angle_to�ǉ�
2014/05/04 1.5.16dev �ϊ��I�����ɏ����N���A����悤�ɂ��܂����B�W���o�͂ɃS�~���o�Ă����̂ō폜���܂����B
2014/05/03 1.5.15dev Input::IME.get_comp_info�ŃR�P��s����C�����܂����B������ƌ����ǂ����܂����B
2014/05/02 1.5.14dev Input::IME.get_comp_info�̃R�[�h��傫���������܂��������̂����ł܂��o�O�邩������܂���B�����
                     Window.ox/oy/ox=/oy=��ǉ����܂����B
2014/05/01 1.5.13dev Input::IME.get_comp_info�ŃR�P��s����C�����܂����B
2014/05/01 1.5.12dev Input::IME.get_comp_info�Ŏ擾���镶���񂪉����邱�Ƃ�����s����C�����܂����B
2014/04/27 1.5.11dev Input::IME�����B
                     Input::IME.get_comp_info��ǉ����܂����B
                     Input::IME.set_cursor/set_font���폜���܂����B
                     Input::IME.get_string�ŕԂ��Ă��镶����UTF-8�Œ�ɂȂ�܂����B
2014/03/08 1.5.10dev Sprite�̃N���X���\�b�h�̓�����ȗ������܂����B
                     Window.folder_dialog�Ńf�t�H���g�f�B���N�g�����w��ł���悤�ɂ��܂����B
                     RenderTarget#draw_font_ex��ox/oy��2�{�K�p�����s����C�����܂����B
                     RenderTarget#mag_filter�̕Ԃ��l��min_filter�̒l�ɂȂ��Ă����̂Œ����܂����B
                     Image.load_tiles/Image#slice_tiles��share_switch�̃f�t�H���g��true�ɕύX���܂����B
                     Encoding.default_internal���ݒ肳�ꂽ�ꍇ�AAPI���Ԃ�������̃G���R�[�h��ϊ�����悤�ɂ��܂����B
                     Font.install���C���X�g�[�������t�H���g����Ԃ��悤�ɂȂ�܂����B
2014/01/05 1.5.9dev Window.autocall�p�~�B������before_call��after_call�ǉ��B
                    Window.draw_box_fill�ǉ��B
                    Input.key_release?/pad_release?/mouse_release?�ǉ��B
                    Font.default/default=�ǉ��B
                    Input�̃I�[�g���s�[�g���A�����t���[���œ����L�[�����x��push�n���\�b�h�Ń`�F�b�N����Ɣ�������
                    �s����C�����܂����B
2013/12/15 1.5.8dev Sprite�̃N���X���\�b�h�̓���𒲐����܂����B
                    Image.new�̃T�C�Y�`�F�b�N���������܂����B
                    Window.draw_tile��sizex/y��nil�ɂ����ꍇ�ɏ����Ɏ��Ԃ�������s����C�����܂����B
                    draw_tile���ɕ`��f�[�^��RenderTarget�������ꍇ�Aupdate�����悤�ɂȂ�܂����B
                    ALT��SPACE��ESC�Ōł܂�s����C�����܂����B
                    SoundEffect#to_a/save���\�b�h��ǉ����܂����Bnew�̈����ɔz����w��ł���悤�ɂȂ�܂����B
                    SoundEffect.new�ŋ�`�g���g�p�����Ƃ��Ƀf���[�e�B����w��ł���悤�ɂȂ�܂����B
2013/10/25 1.5.7dev RenderTarget#ox/oy/ox=/oy=���ǉ�����܂����BWindow.autocall�̎d�l���ύX����܂����B
                    draw_font_ex�n�̃I�v�V����aa�̃f�t�H���g���삪aa����ɕύX����܂����B
                    Image.load_tiles�̏��Z���������������C�����܂����B
                    Window.draw�n���\�b�h��Window���W���[����Ԃ��悤�ɂȂ�܂���(���\�b�h�`�F�C���p)�B
                    �f�o�C�X���X�g���ɃR�P�Ă����̂𓮂��悤�ɂ��܂����B
                    Sprite.update��vanished?==true�̃I�u�W�F�N�g��update���Ă΂Ȃ��Ȃ�܂����B
                    Sprite.draw��visible==true�̃I�u�W�F�N�g��draw���Ă΂Ȃ��Ȃ�܂����B
2013/09/21 1.5.6dev Image#info��tm_descent���Ԃ��悤�ɂȂ�܂����B
                    Window/RenderTarget/Image��draw_font_ex��aa�I�v�V�������ǉ�����A�f�t�H���g���삪�ύX����܂����B
2013/09/08 1.5.5dev Input::IME.compositing?/push_keys/release_keys�ǉ��B
2013/09/07 1.5.4dev Input::IME���W���[���ǉ��B�L�[�萔K_CIRCUMFLEX�ǉ��B
2013/08/15 1.5.3dev Window.folder_dialog�ǉ��B
                    �}�E�X�֘A�̕s��C���BSprite#image��nil�ł�Sprite#draw���G���[�ɂȂ�Ȃ��悤�C��(�`�悳��Ȃ�)�B
                    ���g���C�����̕s��C���B
2013/08/03 1.5.2dev Matrix#inverse�ARenderTarget#resize�AInput.set_cursor�ǉ��B
                    Input.mouse_enable�ŃJ�[�\���������Ȃ��s��C���B
                    Image�N���X�̃��\�b�h�Ńe�N�X�`���������ɃG���[�ɂȂ�����GC�𓮂����ă��g���C����悤�C���B
                    RenderTarget#draw_line�̈ʒu�Y�����C���B
                    Sprite.draw��vanished?==true�ȃI�u�W�F�N�g��draw���Ă΂�Ă����̂ŌĂ΂Ȃ��悤�C���B
                    ���̃��C�u�����Ƃ̑����̂��ߏ����������̏C���B
2013/07/02 1.5.1dev Window.autocall/get_current_mode�ǉ��Bdraw_ex��offset_sync�ǉ��B
                    �E�B���h�E���b�Z�[�W���[�v��ʃX���b�h�ɕ����B
                    �t���[�����[�g����C���B
                    RenderTarget��Window.loop�I�����ɕ`��\��j��/�N���A����悤�C���Bto_image�ł�update����悤�C���B
2013/05/03 1.5.0dev ��ꂽ�̂ŏȗ��B


Ruby
http://www.ruby-lang.org/ja/

DXRuby
http://dxruby.sourceforge.jp/

���[���摜�͋g���g���̃g�����W�V�������C�u�������
http://kikyou.info/tvp/

�w�i�摜�͂��܂���A�t�^�[�l
http://gakaiblog.at.webry.info/

����ȊO�̊G�͐����A�Y�}����(�s���s��)�BGPL�������ł��B
�A�C�R���摜�͖C��������ɕ`���Ē����܂����B


