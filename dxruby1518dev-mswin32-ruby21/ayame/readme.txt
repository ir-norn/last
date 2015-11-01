Ayame/Ruby 0.0.3

１．はじめに

Ayame/RubyはDirectSoundを使うサウンドドライバAyameをRubyで使えるようにするラッパライブラリです。
無圧縮/圧縮wav、ogg、mp3、midiを再生することができます。
メソッドやパラメータが初代Ayame/Rubyから変わってたりするので、昔のやつを使っている人が気をつけてください。
Ruby1.9系用です。


２．Ayameクラス

２-1.クラスメソッド

Ayame.new( filename ) -> Ayame
ファイルを読み込んでAyameオブジェクトを生成します。
0.0.2では指定したファイルが無くてもエラーが出ません(手抜きです)。

Ayame.load_from_memory( string ) -> Ayame
ファイルの内容をまるごと突っ込んだStringオブジェクトを渡してAyameオブジェクトを生成します。

Ayame.update -> nil
フェード処理をします。
DXRubyで使う場合、毎フレーム1回呼び出すようにしてください。
たくさん呼び出しても問題ありませんが、まったく呼び出さないとフェード処理がされません。


２-2.インスタンスメソッド

Ayame#play( loop, fadetime ) -> self
 再生します。
 loopは0で無限、1以上で指定された回数のループとなります。
 fadetimeは秒単位でフェードインにかける時間を指定します。
 とりあえずボリューム100で再生します。
 MIDIファイル以外はストリーミング再生します。

Ayame#stop( fadetime ) -> self
 再生を停止します。
 fadetimeは秒単位でフェードアウトにかける時間を指定します。

Ayame#set_volume( volume, fadetime ) -> self
 音量を設定します。
 volume範囲は0～100です。
 fadetimeは秒単位でボリュームの変更にかける時間を指定します。

Ayame#get_volume -> Integer
 ボリュームを返します。

Ayame#set_pan( pan, fadetime ) -> self
 パンを設定します。
 -100で左、100で右です。
 fadetimeは秒単位でパンの変更にかける時間を指定します。

Ayame#get_pan -> Integer
 パンの設定を返します。

Ayame#pause( fadetime ) -> self
 一時停止します。
 fadetimeは秒単位でフェードアウトにかける時間を指定します。

Ayame#resume( fadetime ) -> self
 一時停止から復帰します。
 fadetimeは秒単位でフェードインにかける時間を指定します。

Ayame#fading? -> true/false
 フェード中の場合にtrueを返します。

Ayame#playing? -> true/false
 再生中の場合にtrueを返します。
 一時停止中もtrueになります。

Ayame#finished? -> true/false
 再生されていない場合にtrueを返します。
 いまのところplaying?の逆になっているようにしか見えませんが、ライブラリのメソッドを呼んでいるだけなので実際のところどう違うのかよくわかっていません。

Ayame#pausing? -> true/false
 一時停止中にtrueを返します。

Ayame#dispose -> self
 Ayameオブジェクトを解放します。
 解放後、メソッドを呼ぶと例外が発生します。

Ayame#prefetch -> self
 ファイルをすべて読み込み、メモリに格納します。
 MIDIファイルの場合は何もしません。

Ayame#predecode -> self
 ファイルをすべて読み込み、データをデコードしてメモリに格納します。メモリは食いますがCPUパワーを節約できます。
 MIDIファイルの場合は何もしません。


３．ライセンス

Ayameはフリーだそうです。
Ayame/Rubyは0.0.2からzlib/libpngライセンスとします。好きに使ってください。
添付のサンプルはパブリックドメインと宣言しておきます。

Ayame
http://www003.upp.so-net.ne.jp/sazanta/entertainment/Luna/Ayame.htm


４．サンプル



５．その他

Ayame/RubyはDXRubyとセットで使うことを想定していますが、必須ではありません。


６．更新履歴

2013/05/25 0.0.3 disposeバグ修正。prefetchとpredecodeを復活。
2013/04/21 0.0.2 midiとフェードに対応。都合によりprefetchとpredecodeを削除。
2010/02/27 0.0.1 公開



