Ayame/Ruby 0.0.3

�P�D�͂��߂�

Ayame/Ruby��DirectSound���g���T�E���h�h���C�oAyame��Ruby�Ŏg����悤�ɂ��郉�b�p���C�u�����ł��B
�����k/���kwav�Aogg�Amp3�Amidi���Đ����邱�Ƃ��ł��܂��B
���\�b�h��p�����[�^������Ayame/Ruby����ς���Ă��肷��̂ŁA�̂̂���g���Ă���l���C�����Ă��������B
Ruby1.9�n�p�ł��B


�Q�DAyame�N���X

�Q-1.�N���X���\�b�h

Ayame.new( filename ) -> Ayame
�t�@�C����ǂݍ����Ayame�I�u�W�F�N�g�𐶐����܂��B
0.0.2�ł͎w�肵���t�@�C���������Ă��G���[���o�܂���(�蔲���ł�)�B

Ayame.load_from_memory( string ) -> Ayame
�t�@�C���̓��e���܂邲�Ɠ˂�����String�I�u�W�F�N�g��n����Ayame�I�u�W�F�N�g�𐶐����܂��B

Ayame.update -> nil
�t�F�[�h���������܂��B
DXRuby�Ŏg���ꍇ�A���t���[��1��Ăяo���悤�ɂ��Ă��������B
��������Ăяo���Ă���肠��܂��񂪁A�܂������Ăяo���Ȃ��ƃt�F�[�h����������܂���B


�Q-2.�C���X�^���X���\�b�h

Ayame#play( loop, fadetime ) -> self
 �Đ����܂��B
 loop��0�Ŗ����A1�ȏ�Ŏw�肳�ꂽ�񐔂̃��[�v�ƂȂ�܂��B
 fadetime�͕b�P�ʂŃt�F�[�h�C���ɂ����鎞�Ԃ��w�肵�܂��B
 �Ƃ肠�����{�����[��100�ōĐ����܂��B
 MIDI�t�@�C���ȊO�̓X�g���[�~���O�Đ����܂��B

Ayame#stop( fadetime ) -> self
 �Đ����~���܂��B
 fadetime�͕b�P�ʂŃt�F�[�h�A�E�g�ɂ����鎞�Ԃ��w�肵�܂��B

Ayame#set_volume( volume, fadetime ) -> self
 ���ʂ�ݒ肵�܂��B
 volume�͈͂�0�`100�ł��B
 fadetime�͕b�P�ʂŃ{�����[���̕ύX�ɂ����鎞�Ԃ��w�肵�܂��B

Ayame#get_volume -> Integer
 �{�����[����Ԃ��܂��B

Ayame#set_pan( pan, fadetime ) -> self
 �p����ݒ肵�܂��B
 -100�ō��A100�ŉE�ł��B
 fadetime�͕b�P�ʂŃp���̕ύX�ɂ����鎞�Ԃ��w�肵�܂��B

Ayame#get_pan -> Integer
 �p���̐ݒ��Ԃ��܂��B

Ayame#pause( fadetime ) -> self
 �ꎞ��~���܂��B
 fadetime�͕b�P�ʂŃt�F�[�h�A�E�g�ɂ����鎞�Ԃ��w�肵�܂��B

Ayame#resume( fadetime ) -> self
 �ꎞ��~���畜�A���܂��B
 fadetime�͕b�P�ʂŃt�F�[�h�C���ɂ����鎞�Ԃ��w�肵�܂��B

Ayame#fading? -> true/false
 �t�F�[�h���̏ꍇ��true��Ԃ��܂��B

Ayame#playing? -> true/false
 �Đ����̏ꍇ��true��Ԃ��܂��B
 �ꎞ��~����true�ɂȂ�܂��B

Ayame#finished? -> true/false
 �Đ�����Ă��Ȃ��ꍇ��true��Ԃ��܂��B
 ���܂̂Ƃ���playing?�̋t�ɂȂ��Ă���悤�ɂ��������܂��񂪁A���C�u�����̃��\�b�h���Ă�ł��邾���Ȃ̂Ŏ��ۂ̂Ƃ���ǂ��Ⴄ�̂��悭�킩���Ă��܂���B

Ayame#pausing? -> true/false
 �ꎞ��~����true��Ԃ��܂��B

Ayame#dispose -> self
 Ayame�I�u�W�F�N�g��������܂��B
 �����A���\�b�h���ĂԂƗ�O���������܂��B

Ayame#prefetch -> self
 �t�@�C�������ׂēǂݍ��݁A�������Ɋi�[���܂��B
 MIDI�t�@�C���̏ꍇ�͉������܂���B

Ayame#predecode -> self
 �t�@�C�������ׂēǂݍ��݁A�f�[�^���f�R�[�h���ă������Ɋi�[���܂��B�������͐H���܂���CPU�p���[��ߖ�ł��܂��B
 MIDI�t�@�C���̏ꍇ�͉������܂���B


�R�D���C�Z���X

Ayame�̓t���[�������ł��B
Ayame/Ruby��0.0.2����zlib/libpng���C�Z���X�Ƃ��܂��B�D���Ɏg���Ă��������B
�Y�t�̃T���v���̓p�u���b�N�h���C���Ɛ錾���Ă����܂��B

Ayame
http://www003.upp.so-net.ne.jp/sazanta/entertainment/Luna/Ayame.htm


�S�D�T���v��



�T�D���̑�

Ayame/Ruby��DXRuby�ƃZ�b�g�Ŏg�����Ƃ�z�肵�Ă��܂����A�K�{�ł͂���܂���B


�U�D�X�V����

2013/05/25 0.0.3 dispose�o�O�C���Bprefetch��predecode�𕜊��B
2013/04/21 0.0.2 midi�ƃt�F�[�h�ɑΉ��B�s���ɂ��prefetch��predecode���폜�B
2010/02/27 0.0.1 ���J



