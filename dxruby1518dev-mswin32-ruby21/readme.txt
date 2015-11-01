DXRuby1.5.18dev

■１．はじめに

 DXRuby1.5系は開発版です。 大きな新機能はありませんが、コマゴマとした機能追加と、基盤部分への修正が入っています。
 正式版に取り込まれていない仕様は未確定で、今後予告無く変更される可能性があります。
 そういえばマニュアルに書き忘れていたっぽいのですが、DXRuby::VERSIONでバージョンが取得できます。


■２．DXRuby1.4.1から大きく変わったところ

 Vector/Matrixクラスが追加されました。
 各クラス/モジュールにいろいろなメソッドが追加されました。
 Input::IMEモジュールにより日本語入力ができるようになりました。
 Window.loopが複数置けるようになりました。
 内部のほとんどをUNICODE化しました。
 デフォルトアイコンが設定されました。

■２-1. DXRuby1.5.17devから変わったところ

 Spriteの衝突判定まわりのメモリバグを修正とパフォーマンス改善。
 衝突判定の配列をネストできるよう修正。
 Sprite#visibleがfalseのオブジェクトは衝突判定処理がされないよう修正。
 Inputモジュールの定数の変更の取り消し。
 Input.push?/down?/release?削除。


■３．制限

 バグがあるかもしれませんので使ってみて予想外の動きをしたら聞いてください。


■４．DXRuby1.4.1からの差分リファレンス&修正点

■４-1.Windowモジュール

Window.loop( close_cancel = nil ) -> nil

 何回でも置けるようになりました。
 引数のclose_cancelはtrueにするとユーザの閉じる操作を無視するようになります。閉じる操作がされた場合、Input.updateもしくはInput.requested_close?でtrueが返ってくるので、それをチェックして自分でbreakするなりください。

Window.close/closed?/created?

 closeはウィンドウを閉じます。closed?は閉じられていたらtrue、created?は表示されていたらtrueを返します。

Window.full_screen/full_screen?

 Window.windowed/windowed?の逆です。


■４-2．Window/RenderTarget共通

Window.draw_text/draw_text_ex/draw_tiles
RenderTarget#draw_text/draw_text_ex/draw_tiles

 それぞれ、draw_font/draw_font_ex/draw_tileのaliasです。


■４-3. Fontクラス

Font#name

 実際に生成されたフォント名が返ります。フォントを生成する際に与えた名称が無かったり省略した場合に、何が生成されたかを知ることができます。Font#fontnameは指定した名称が返ります。


■４-4. Spriteクラス

 Sprite#visibleがfalseのオブジェクトはSprite#collision_enableがtrueでも衝突しなくなりました。

Sprite#xy -> Vector
Sprite#xy=( v ) -> v

 2要素のVectorオブジェクトでxyを同時に取得・設定します。
 Sprite#xy=に3要素のVectorオブジェクトを渡すと始めの2要素のみ使いますので[x, y, 1]という形式のVectorでも設定することができます。3要素Vectorを指定してもこのメソッドではzは更新されません。

Sprite#xyz -> Vector
Sprite#xyz=( v ) -> v

 3要素のVectorオブジェクトでxyzを同時に取得・設定します。zは描画優先順位に使われます。
 Sprite#xyz=に4要素のVectorオブジェクトを渡すと始めの3要素のみ使いますので[x, y, z, 1]という形式のVectorでも設定することができます。

Sprite.check

 コールバックメソッドhit/shotに引数が無くてもエラーにならなくなりました。

Sprite.render/Sprite#render

 それぞれdrawのaliasです。Sprite.renderは渡された配列内のオブジェクトのrenderを呼び出します。


■４-5. Inputモジュール

 パッドボタンとマウスボタン定数の定義値が大幅に変更されました。
 →定数の定義値は元に戻りました。統一メソッドInput.push?/down?/release?も削除されました。

Input.requested_close? -> true/false

 Window.loopにtrueを渡した場合に、ユーザが閉じようとしていたらtrueが返ります。

Input.mouse_x/mouse_y

 それぞれmouse_pos_x/mouse_pos_yのaliasです。


■４-5b. Input::IMEモジュール

Input::IME.enable=(v) -> v
Input::IME.enabled?

 IMEのON/OFFをtrue/falseで設定します。デフォルトはfalseです。
 trueにすると全角/半角キーでIMEを有効にできるようになります。

Input::IME.get_string -> String

 IMEから渡された文字列を返します。変換中の文字列は画面には表示されますが渡されず、確定時に渡されます。
 文字コードはWindowsなのでWindows-31Jとなります。UTF-8がいい人はエンコード変換してください。
 このメソッドで返ってくる文字列は前フレームから今フレームまでの間に入力された文字のみです。フレームを超えてバッファされることはありません。毎回自動的にクリアされるのでバッファクリアメソッドもありません。
 DXRubyプログラミングにおいて、バッファは取得しないけど入力内容は残しておいてほしいフレームがあることを想定していないからなのですが、もし作者の想定範囲外で有用な使い方のアイデアをお持ちのかたはぜひ教えてください。ささっと作ります。
 また、このメソッドでは制御コードは返ってきません。そういったキーはInput::IME.push_keysを使って判定してください。
 返ってくる文字列は、変換候補にUNICODE依存文字が存在している都合でUTF-8固定となります。

Input::IME.compositing? -> true/false

 IME入力中かどうかをtrue/falseで返します。カーソルの移動などをInput.key_push?で処理している場合、IME入力中でも受け取れてしまうので、カーソル移動がIME上とアプリ上で同時に発生してしまいます。こういう場合はこのメソッドで入力中を判定してカーソル移動などの処理を省きます。

Input::IME.push_keys -> Array
Input::IME.release_keys -> Array

 前フレームから今フレームまでの間に押されたキー/離されたキーの定数が配列に格納されて返ってきます。IMEに横取りされたキーは格納されませんので、文字入力を扱う場合の特殊キー判定に使えます。
 システムのオートリピートが反映されます。オートリピート中はpush_keysに値が連続して入ってきますが、release_keysにはキーが離されるまで入ってきません。

Input::IME.get_comp_info -> Struct

 変換中の各種情報を取得します。Structオブジェクトを返します。
 この構造体には以下の情報が格納されています。
comp_str...変換中の文字列全体です。
comp_attr...変換中の一文字単位で属性の値が格納された配列です。
cursor_pos...変換中のカーソル位置です。
can_list...変換候補(candidate)の文字列が格納された配列です。表示されるべき範囲のみが格納されます。
selection...can_listのうち、選択されている候補のindexです。
selection_total...変換候補全体(totalの値)のうち、何番目が選択中かを表します。
page_size...一度に表示されるべき候補数を表します。
total...変換候補全体の数を表します。

comp_attrに格納される値は以下の4種類で、定数として定義されています。
Input::IME::ATTR_INPUT...入力中 
Input::IME::ATTR_TARGET_CONVERTED...選択されてて変換されてる
Input::IME::ATTR_CONVERTED...選択されてなくて変換されてる
Input::IME::ATTR_TARGET_NOTCONVERTED...選択されてて変換されてない

 変換候補の全体の数はtotalで取得できますが、取得できる文字列は表示されるべきページの範囲のみです。全体の文字列は取得できません。取れてもいいんですが、必要ないかなーと。
 候補の選択やページ切り替えなどはIME側で処理されていますので、Ruby側で制御する必要はありません。
 返ってくる文字列は、変換候補にUNICODE依存文字が存在している都合でUTF-8固定となります。
 なにぶんややこしい機能なので使いにくいところもあると思いますが、作るのも初めてなので至らないところはあるはずです。質問や要望はビシバシどうぞ。


■４-6. Matrixクラス

Matrix.new( m = nil ) -> Matrix

 Matrixオブジェクトを生成します。
 引数を省略すると4x4要素の単位行列を返します。
 vは配列で、[[x1,y1,z1,w1],[x2,y2,z2,w2],[x3,y3,z3,w3],[x4,y4,z4,w4]]という形式で渡すと4x4要素の行列が作られます。
 同様に3x3、2x2、1x1(?)の行列を生成することができます。
 ゲーム用なので正方行列しか扱えません。

Martix.rotation( angle ) -> Matrix

 3x3サイズのz軸回転行列を返します。2DのVector座標を回転するのに使います。

Martix.rotation_x( angle ) -> Matrix

 4x4サイズのx軸回転行列を返します。3DのVector座標を回転するのに使います。

Martix.rotation_y( angle ) -> Matrix

 4x4サイズのy軸回転行列を返します。3DのVector座標を回転するのに使います。

Martix.rotation_z( angle ) -> Matrix

 4x4サイズのz軸回転行列を返します。3DのVector座標を回転するのに使います。

Martix.scaling(sx, sy = nil, sz = nil) -> Matrix

 スケーリング行列を返します。引数は倍率を指定します。
 引数を指定した数+1サイズの行列を返します。

Martix.translation(tx, ty = nil, tz = nil) -> Matrix

 移動行列を返します。引数は移動量を指定します。
 引数を指定した数+1サイズの行列を返します。

Martix.look_at( eye, at, up ) -> Matrix

 3Dのビュー行列を返します。
 eyeはカメラ位置座標の3要素Vector、atは画面の中心にする座標の3要素Vector、upはカメラの上方向を表す3要素Vectorを指定します。
 返ってくる行列はeyeの位置からatの方向を見るupが上方向になるビュー行列です。

Martix.projection( width, height, zn, zf ) -> Matrix

 3Dの射影変換行列を返します。
 画面の幅、高さ、zn、zfを指定します。

Martix.projection_fov( fov, aspect, zn, zf ) -> Matrix

 3Dの射影変換行列を返します。
 視野角、縦/横のアスペクト比、zn、zfを指定します。

Martix#*( m ) -> Matrix

 selfのと引数のMatrixオブジェクトとの積を返します。

Martix#to_s -> String

 selfを文字列化します。

Martix#to_a -> Array

 selfを配列化します。

Matrix#inverse -> Matrix

 selfの逆行列を生成します。


■４-7. Vectorクラス

Vector.new( x, y = nil, z = nil, w = nil ) -> Vector

 Vectorオブジェクトを生成します。
 指定した数だけの要素を持ったVectorオブジェクトとなります。

Vector.distance( v1, v2 ) -> Float

 2つのVectorオブジェクトの距離を計算して返します。

Vector.cross_product( v1, v2 ) -> Vector

 2つのVectorオブジェクトの外積を計算し、結果のVectorオブジェクトを生成して返します。

Vector.dot_product( v1, v2 ) -> Float

 2つのVectorオブジェクトの内積を返します。

Vector#*( v ) -> Vector

 selfに対してvを掛け算し、結果のVectorオブジェクトを生成して返します。
 引数として有効なのはFixnum/Floatなどの数値オブジェクト、Vectorオブジェクト、Matrixオブジェクトです。
 Vectorオブジェクトを指定した場合、内積ではなく、それぞれの項目同士の積が並んだVectorオブジェクトになります。

Vector#+( v ) -> Vector

 selfに対してvを加算し、結果のVectorオブジェクトを生成して返します。
 引数として有効なのはFixnum/Floatなどの数値オブジェクト、Vectorオブジェクトです。

Vector#-( v ) -> Vector

 selfに対してvを減算し、結果のVectorオブジェクトを生成して返します。
 引数として有効なのはFixnum/Floatなどの数値オブジェクト、Vectorオブジェクトです。

Vector#-@ -> Vector

 selfに対して符号を逆転したVectorオブジェクトを生成して返します。

Vector#/( v ) -> Vector

 selfに対してvを除算し、結果のVectorオブジェクトを生成して返します。
 引数として有効なのはFixnum/Floatなどの数値オブジェクト、Vectorオブジェクトです。

Vector#to_s -> String

 selfを文字列化します。

Vector#to_a -> Array

 selfを配列化します。

Vector#x -> Float

 selfの第1要素を返します。

Vector#y -> Float

 selfの第2要素を返します。

Vector#z -> Float

 selfの第3要素を返します。

Vector#w -> Float

 selfの第4要素を返します。

Vector#xy -> Vector

 selfの第1、第2要素のみを抜き出したVectorオブジェクトを返します。

Vector#xyz -> Vector

 selfの第1、第2、第3要素のみを抜き出したVectorオブジェクトを返します。

Vector#size -> Fixnum

 selfの要素数を返します。

Vector#normalize -> Vector

 正規化したVectorオブジェクトを返します。

Vector#==( v ) -> true/false

 selfと引数のVectorオブジェクトの内容を比較します。

Vector#translate(x, y = nil, z = nil, w = nil) -> Vector

 selfの要素にそれぞれの引数を加算し、結果のVectorオブジェクトを生成して返します。

Vector#rotate( angle, center_x=0, center_y=0 ) -> Vector

 selfをz軸回転し、結果のVectorオブジェクトを返します。2DVector用です。
 center_x/center_yで回転中心を指定できます。

Vector#rotate_x( angle ) -> Vector

 selfをx軸回転し、結果のVectorオブジェクトを返します。3DVector用です。

Vector#rotate_y( angle ) -> Vector

 selfをy軸回転し、結果のVectorオブジェクトを返します。3DVector用です。

Vector#rotate_z( angle ) -> Vector

 selfをz軸回転し、結果のVectorオブジェクトを返します。3DVector用です。

Vector#angle_to( v ) -> Float

 selfからvに向けた角度を360度系で返します。


■４-8. Soundクラス

Sound.load_from_memory( string ) -> Sound

 Stringオブジェクトでファイルデータを渡してSoundオブジェクトを生成できます。

Sound#pan/pan=(v)

 パンの取得・設定ができます。値は-10000から+10000まで、左右の音のdB差を表します。

Sound#frequency/frequency=(v)

 周波数の取得・設定ができます。


■５. Ayameさん

 この開発版にはサウンドドライバAyameを扱う拡張ライブラリのテスト版Ayame/Ruby0.0.3を同梱しています。
 mp3、ogg、midi、wavの各ファイルを扱え、フェードイン/アウトなどもサポートしています。
 こちらもぜひお試しください。


■６．ライセンス

 zlib/libpngライセンスを適用します。
 同梱しているサンプルはパブリックドメインとします。


■７．更新履歴
2015/04/25 1.5.18dev Spriteの衝突判定まわりのメモリバグを修正とパフォーマンス改善。
                     衝突判定の配列をネストできるよう修正。
                     Sprite#visibleがfalseのオブジェクトは衝突判定処理がされないよう修正。
                     Inputモジュールの定数の変更の取り消し。
                     Input.push?/down?/release?削除。
2014/12/23 1.5.17dev Window.loopが複数置けるようになりました。
                     Inputのキー定数値変更
                     デフォルトアイコンを設定
                     内部UNICODE化で表示できなかった文字が表示できるようになりました。
                     Window.close/closed?/created?追加
                     Sprite#param_hashのキー変更(scalex→scale_xなど)
                     font#name追加
                     Window/RenderTargetにdraw_text/draw_text_ex/draw_tiles/full_screen/full_screen?追加
                     Sprite.render、Sprite#render追加
                     Sprite.checkのコールバックメソッドに引数が無くても動くようにしました。
                     Image#change_hlsの色計算バグ修正
                     Input.push?/down?/release?追加
                     Window.loopに引数close_cancel追加
                     Sound#pan/pan=/frequency/frequency=追加
                     Sound.load_from_memory追加
                     Vector#rotateに中心点の指定を追加
                     Vector#angle_to追加
2014/05/04 1.5.16dev 変換終了時に情報をクリアするようにしました。標準出力にゴミが出ていたので削除しました。
2014/05/03 1.5.15dev Input::IME.get_comp_infoでコケる不具合を修正しました。ちょっと効率良くしました。
2014/05/02 1.5.14dev Input::IME.get_comp_infoのコードを大きく整理しましたがそのせいでまたバグるかもしれません。ｺﾞﾒﾝﾈ
                     Window.ox/oy/ox=/oy=を追加しました。
2014/05/01 1.5.13dev Input::IME.get_comp_infoでコケる不具合を修正しました。
2014/05/01 1.5.12dev Input::IME.get_comp_infoで取得する文字列が化けることがある不具合を修正しました。
2014/04/27 1.5.11dev Input::IME完成。
                     Input::IME.get_comp_infoを追加しました。
                     Input::IME.set_cursor/set_fontを削除しました。
                     Input::IME.get_stringで返ってくる文字列がUTF-8固定になりました。
2014/03/08 1.5.10dev Spriteのクラスメソッドの動作を簡略化しました。
                     Window.folder_dialogでデフォルトディレクトリを指定できるようにしました。
                     RenderTarget#draw_font_exでox/oyが2倍適用される不具合を修正しました。
                     RenderTarget#mag_filterの返す値がmin_filterの値になっていたので直しました。
                     Image.load_tiles/Image#slice_tilesのshare_switchのデフォルトをtrueに変更しました。
                     Encoding.default_internalが設定された場合、APIが返す文字列のエンコードを変換するようにしました。
                     Font.installがインストールしたフォント名を返すようになりました。
2014/01/05 1.5.9dev Window.autocall廃止。かわりにbefore_callとafter_call追加。
                    Window.draw_box_fill追加。
                    Input.key_release?/pad_release?/mouse_release?追加。
                    Font.default/default=追加。
                    Inputのオートリピート時、同じフレームで同じキーを何度もpush系メソッドでチェックすると発生する
                    不具合を修正しました。
2013/12/15 1.5.8dev Spriteのクラスメソッドの動作を調整しました。
                    Image.newのサイズチェックを強化しました。
                    Window.draw_tileでsizex/yをnilにした場合に処理に時間がかかる不具合を修正しました。
                    draw_tile時に描画データがRenderTargetだった場合、updateされるようになりました。
                    ALT→SPACE→ESCで固まる不具合を修正しました。
                    SoundEffect#to_a/saveメソッドを追加しました。newの引数に配列を指定できるようになりました。
                    SoundEffect.newで矩形波を使用したときにデューティ比を指定できるようになりました。
2013/10/25 1.5.7dev RenderTarget#ox/oy/ox=/oy=が追加されました。Window.autocallの仕様が変更されました。
                    draw_font_ex系のオプションaaのデフォルト動作がaaありに変更されました。
                    Image.load_tilesの除算がおかしい問題を修正しました。
                    Window.draw系メソッドがWindowモジュールを返すようになりました(メソッドチェイン用)。
                    デバイスロスト時にコケていたのを動くようにしました。
                    Sprite.updateがvanished?==trueのオブジェクトのupdateを呼ばなくなりました。
                    Sprite.drawがvisible==trueのオブジェクトのdrawを呼ばなくなりました。
2013/09/21 1.5.6dev Image#infoがtm_descentも返すようになりました。
                    Window/RenderTarget/Imageのdraw_font_exにaaオプションが追加され、デフォルト動作が変更されました。
2013/09/08 1.5.5dev Input::IME.compositing?/push_keys/release_keys追加。
2013/09/07 1.5.4dev Input::IMEモジュール追加。キー定数K_CIRCUMFLEX追加。
2013/08/15 1.5.3dev Window.folder_dialog追加。
                    マウス関連の不具合修正。Sprite#imageがnilでもSprite#drawがエラーにならないよう修正(描画されない)。
                    リトライ処理の不具合修正。
2013/08/03 1.5.2dev Matrix#inverse、RenderTarget#resize、Input.set_cursor追加。
                    Input.mouse_enableでカーソルが消せない不具合修正。
                    Imageクラスのメソッドでテクスチャ生成時にエラーになったらGCを動かしてリトライするよう修正。
                    RenderTarget#draw_lineの位置ズレを修正。
                    Sprite.drawでvanished?==trueなオブジェクトもdrawが呼ばれていたので呼ばないよう修正。
                    他のライブラリとの相性のため初期化処理の修正。
2013/07/02 1.5.1dev Window.autocall/get_current_mode追加。draw_exにoffset_sync追加。
                    ウィンドウメッセージループを別スレッドに分離。
                    フレームレート制御修正。
                    RenderTargetをWindow.loop終了時に描画予約破棄/クリアするよう修正。to_imageでもupdateするよう修正。
2013/05/03 1.5.0dev 疲れたので省略。


Ruby
http://www.ruby-lang.org/ja/

DXRuby
http://dxruby.sourceforge.jp/

ルール画像は吉里吉里のトランジションライブラリより
http://kikyou.info/tvp/

背景画像はきまぐれアフター様
http://gakaiblog.at.webry.info/

それ以外の絵は水視アズマさま(行方不明)。GPLだそうです。
アイコン画像は鳴海つかささんに描いて頂きました。


