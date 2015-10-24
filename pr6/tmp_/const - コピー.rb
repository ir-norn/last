# -*- encoding: UTF-8 -*-

require "__tewi/req"  if $0 ==__FILE__

if $0 ==__FILE__
  require "ostruct"
  require 'dxruby'
end
#
# TOPDIR の設定などもしているので必ずプロジェクトの最上位ディレクトリにおいておく


# L_const nimo sukosi module Yuyuko
module Yuyuko
  FONT           = Font.new(30, "Meiryo UI" )
  FONT_SELECT    = Font.new(30, "Meiryo UI" )
  FONT_SELECT_NO = Font.new(30, "Meiryo UI" )
  # TOP_NODE

  class << self
    attr_accessor :TOP_NODE
    #
    #
    # attr_accessor :LOOP_NODE

    # 枠
    # このあたりも初期化場所を要検討
    # でも、ここのデータはゲームごとにあまりいじらないデータとする
    #
    attr_accessor :client_x
    attr_accessor :client_y
    attr_accessor :client_width
    attr_accessor :client_height

    # attr_accessor :border_right
    # attr_accessor :border_left
    # attr_accessor :border_top
    # attr_accessor :border_bottom

    [
     :font_select_no_color , [ 0xc9 , 0xab , 0xd3 ] ,
     :font_select_color    , [ 0x95 , 0xc7 , 0xab ] ,
     :font_select_no       , FONT_SELECT_NO     ,
     :font_select          , FONT_SELECT     ,
     :font                 , FONT            ,
     :font2                , Font.new(70, "Comic Sans MS" ) ,
     :top_sym              , "hakugyokuro"    ,
     :TOPDIR               , File.dirname(__FILE__)+"/" ,
     :dd                   , Image.new(1,1,[1,100,100,100])
    ].each_slice(2) do | sym , nnn |
      define_method sym do
        nnn
      end
    end
    # これちょっと不安なので後で何とかしたい
    #
    eval( open("./dat/meta/const_font_meta_data.rb").read )
    .each_slice(2) do | sym , nnn |
      define_method sym do
        nnn
      end
    end
    # font _meta
   # define _ meta
  end
end


# ----------- init --------
Window.caption = "ご注文はうさぎですか？"
Window.x       = 40
Window.y       = 0
#Window.width   = 640
#Window.height  = 480
# true --- window mode --------------- false --- full screen mode ---------
Window.windowed = true
#Window.windowed = false
Window.fps = 60
#
# Window.frameskip?
# Window.frameskip=val
# true で 1フレームだけ描画処理を省く
# Window.frameskip = true
Window.bgcolor = [0,0,0]
Window.create




# $Scarlet.var_add :Lib , :Conf
# $Scarlet.Lib = Object.new
# $Scarlet.Lib.extend Create_Generator
# $Scarlet.Conf = Object.new
# $Scarlet.Conf.var_add :TOP_NODE , :TOP_DIR # , :CLIENT_X , :CLIENT_Y , :CLIENT_WIDTH, :CLIENT_HEIGHT
# $Scarlet.Font
# $Scarlet.Sound
# $Scarlet.Bgm
#　フォント・イメージ・は使うシーンごとにメタ?
#

# Scarlet
class STACK_Scarlet
  attr_accessor :sound     # BGM 効果音
  attr_accessor :dd        # 画像 まとめ
  attr_accessor :frandoll  #  :ok  格納用
  attr_accessor :remilia   #  シーン間の変数
  attr_accessor :izayoi    # DEBUG mode is true
  attr_accessor :message   # ハッシュにメッセージ入れて　.message[:field].pop  のような感じに
  attr_accessor :stack       # stack 雑用
# 2015 10 24　add
  attr_accessor :Font ,:Sound,:Bgm,:Conf,:Lib, :TOP_NODE ,:TOP_SYM , :TOP_DIR
#
  def initialize
    @Font = Font.new(30, "Comic Sans MS" )
    # top レベルのメッセージ　last.rb
    @frandoll = []
    # シーン間のデータやり取り
#    @remilia  = Hash.new
#    @remilia.default_proc = lambda do | h , k |
#       h[ k ] = Hash.new
#    end
    # あたり判定 表示 非表示
    @izayoi = true
    # シーン、オブジェクト間など、色々なメッセージ
    @message = Hash.new
    @message.default_proc = lambda do | h , k |
       h[ k ] = []
    end
    #
    # 雑用スタック
#    @stack = Hash.new
#    @stack.default_proc = lambda do | h , k |
#       h[ k ] = []
#    end

    # oto
    @sound   = Hash.new
    @sound[:title]        = Sound.new("sound/nil.mid")
    @sound[:staff_roll]   = Sound.new("sound/nil.mid")
    @sound[:ed]           = Sound.new("sound/nil.mid")
    @sound[:field_0]      = Sound.new("sound/nil.mid")
    @sound[:field_0_boss] = Sound.new("sound/nil.mid")

    # @sound[:title]        = Sound.new("sound/タイトル.mid")
    # @sound[:staff_roll]   = Sound.new("sound/staff_roll.mid")
    # @sound[:ed]           = Sound.new("sound/ed.mid")
    # @sound[:field_0]      = Sound.new("sound/field_0.mid")
    # @sound[:field_0_boss] = Sound.new("sound/field_0_boss.mid")
# ------------------------------ ittann 　コメントアウト
    @sound[:bgm_all_stop] = ->*h{
    #   if h.first
    #     @sound[ h.first ].stop rescue p :__const_rb_sound__bug
    #   else
    #     @sound.each do | k , v |
    #       @sound[ k ].stop rescue p
    #     end
    #   end
}
    # def @sound.play_ex  name
    #     $Scarlet.sound[:bgm_all_stop].call
    #     $Scarlet.sound[ name ].play
    # end
# --------------------------------------
    # play_ex　で　停止 ＆ 再生にする
    # $Scarlet.sound[:sym].play_ex

    # 色の段階を作って、メモしてメタする

    (["shot"]*20).zip([""].cycle.each_with_index).each do |m|
#       m = m.flatten.join.to_sym
#       @dd.var_add_ex m
    end
    # dd.shot0
    [ Image.new(10,10,[170,180,240]) , Image.new(10,10,[170,240,140]) ,  Image.new(10,10,[220,170,180]) , ]
    .each_with_index do | m , i |
      eval"@dd.var_add_ex :shot#{i}"
      eval"@dd.shot#{i} = m"
    end
    # enemy
    [ Image.new(50,50,[170,180,240]) , Image.new(50,50,[170,240,140]) ,  Image.new(50,50,[220,170,180]) , ]
    .each_with_index do | m , i |
      eval"@dd.var_add_ex :enemy#{i}"
      eval"@dd.enemy#{i} = m"
    end
    # effect
    [ Image.new(20,20,[170,180,240]) , Image.new(20,20,[170,240,140]) ,  Image.new(20,20,[220,170,180]) , ]
    .each_with_index do | m , i |
      eval"@dd.var_add_ex :effect#{i}"
      eval"@dd.effect#{i} = m"
    end
#    @sound.su    = Sound.new("sound/te.mid")
#    @sound.su.loop_count  = 0
  end
end
$Scarlet = STACK_Scarlet.new
# debug mode
$de      = true
$de_loop_command = true
