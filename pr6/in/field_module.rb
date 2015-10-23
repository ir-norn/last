# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__


#---------------------------------------------------------------------------
#
#
#
#
# --------------------------  default collision of Nazrin ---------------------
#
#
#
#
#---------------------------------------------------------------------------

module Nazrin
  include Collision_hit_shot
  include Patchouli_Knowledge
  attr_accessor :life , :atack , :dif
# ------------------------------------------------------------------------
#
#      extend された時にデフォルト値で初期化
#   でも Mikomiko_moduleのほうで個別に o.life は設定する
#   現在　dif　（　防御力 ）　は未使用
#
#   life 　　ライフ
#   atack　 攻撃力
#   dif    防御力
#
# ------------------------------------------------------------------------

  def self.extended o
    o.life  = 1
#    o.atack = 0
  end

#
#
#
# 画面の外にでたら消す
#
  def self.rect_delete o
    if o.d.class == String
      unless Lumia.blockhit o.x , o.y , 10 , 10 , 
         -100 , -100 , Window.width+200 , Window.height+200
         o.delete
      end
    else
      unless Lumia.blockhit o.x , o.y , o.d.width , o.d.height ,
         -100 , -100 , Window.width+200 , Window.height+200
         o.delete
      end
    end
  end

# ------------------------------------------------------------------------
#
# 　仕様： def hit_shot
#
#   dxrubyex # collisionCircle の　def hit と def shot のどちらかが呼び出されたら
# 　　呼ばれるメソッド
#
#   comment :
#      当たり判定の、オブジェクト消滅　＆　エフェクト発生など
#  　　  エフェクト発生あたりは、オブジェクトのデストラクタに仕掛ける手もあり
#   　　　とりあえずデフォルトエフェクトは、ここでいくつか設定
#  　　　 それ以外のエフェクトを表示したい場合には、オブジェクトごとに仕掛けるのがいいかも
#
# ------------------------------------------------------------------------

  def hit_shot o
    self.life -= o.atack
    if self.life < 0
      self.life = 0
      case self.sym
      when /item_tokuten/
        Effect.tokuten_de self                
        $Patchouli.user.tokuten += 20
      when /item/
         $Patchouli.user.spell += 1
         $Patchouli.user.tokuten += 100
         # effect_create
      when /enemy_shot/
        Effect.ef_enemy_shot self

      when /enemy/
        Effect.enemy_de self
#        if rand(2) == 0
        Item.spell_add self
      when /user_shot/
      when /user/
        $Patchouli.user.zanki -= 1
        if $Patchouli.user.zanki < 0
          $Scarlet.message[:field] << :user_deth2
        else
          $Scarlet.message[:field] << :user_deth
        end
      end# case
      self.delete
    end
    # effect_create
    Effect.ef0 self
    

  end # shot_hit



# ------------------------------------------------------------------------
#
#   Nazrin.collision_set_check o
#      当たり判定
#
#　　　　　全オブジェクトから、user   enemy   shot  などを区別
#　　　　　これはオブジェクト生成時に、既に区分分けをしてると、少しだけ速度向上が可能
#
#    [ 準BUG ] 
#      Tree_Diagram.new　と　Task do との　初期化タイミングの問題で
#      Task do 内の初期化が行われる前にcollisionチェックされてしまうと
#      まだ、collisionが初期化されていないからエラーになる　1フレームの誤差
#　　　　　なので func_old の値をみたり、
#      begin rescue とかで回避
#    　　あとでなんとかする
#
# ------------------------------------------------------------------------

    def self.collision_set_check o , hs = Hash.new

      scarlet_user       = Patchouli_Knowledge.user
      scarlet_user_shot  = []
      scarlet_enemy      = []
      scarlet_enemy_shot = []
      scarlet_item       = []
      
      #
      # 相対参照が好ましいけど遅いので格納 ＆ 更新
      # 
      #
      Patchouli_Knowledge.user_shot_set   scarlet_user_shot
      Patchouli_Knowledge.enemy_set       scarlet_enemy
      Patchouli_Knowledge.enemy_shot_set  scarlet_enemy_shot
      Patchouli_Knowledge.item_set        scarlet_item
      
      Patchouli_Knowledge.miko.search_down_all_test.each do | k , o |
          case o.sym 
          when /enemy_shot/
            scarlet_enemy_shot << o
          when /enemy/
            scarlet_enemy << o
          when /user_shot/
            scarlet_user_shot << o
          when /item/
            scarlet_item << o
          end
      end 

      user           = []
      enemy_c        = []
      user_shot_c    = []
      enemy_shot_c   = []
      item_c         = []

      
      # なんか初期化タイミングずれているので、明示的にチェックする
      # 多分自分より上位ノードにタスク追加したときに
      # ツリーは深さ優先探索なので
      # 初期化が１フレ遅れてしまう
      
      
      if scarlet_user
        begin
          user = scarlet_user.collision.set( scarlet_user.x , scarlet_user.y )
        rescue
          user = []
        end
      end
      func = ->o{
         if o.func_old
           o.collision.set o.x , o.y
         else
           []
         end
      }
      enemy_c      = scarlet_enemy.nue(&func) if scarlet_enemy
      enemy_shot_c = scarlet_enemy_shot.nue(&func) if scarlet_enemy_shot
      user_shot_c  = scarlet_user_shot.nue(&func)   if scarlet_user_shot
      item_c       = scarlet_item.nue(&func) if scarlet_item


#      p enemy_c
#      p user_shot_c
       Collision.check( enemy_c , user_shot_c ) 
       Collision.check( enemy_shot_c , user ) 
       Collision.check( enemy_c , user ) 
       Collision.check( item_c  , user ) 


      [
      "user_shot #{scarlet_user_shot.size}" ,
      "enemy #{scarlet_enemy.size}" ,
      "enemy_shot #{scarlet_enemy_shot.size}" ,
      ].each_with_index do | m , i |
        Window.drawFont 30 ,  50 + i*50 , m , Yuyuko.font , { alpha: 200 , color: [220,170,220] }
      end if hs[:de] != :non



    end
end


# --------------------------------------------------------------
#
# STAGE 1 , 2 ,3 ... で変わらない固定のもの
#
#
#
#  Field_module
# 
# いまはincludeしちゃってるけど、　
#  もしかしたら　特異メソッド化したほうがいい あ、 extend すればいい
#
#  todo :
#    会話インタラプト
#　　　　create_logo　あたりを整理してライブラリ化する
#
# --------------------------------------------------------------


module Field_module

#
# field_old のひどいコードが動いてる
#
    def field_key o
        Field_old.game_stop o
    end
# ------------------------------------------------
#
# ここら辺の　データは定数としてconstへもっていくか、
#　シーンに入るごとに更新
#
#-------------------------------------------------
    def background_create o , hs = Hash.new
      top        = Image.load("./img/back/top.png")
      left       = Image.load("./img/back/left.png")
      right      = Image.load("./img/back/right.png")
      bottom     = Image.load("./img/back/bottom.png")
      right_menu = Image.load("./img/back/right_menu.png")
      right_logo = Image.load("./img/back/right_logo.png")
      
      main       = Struct.new(:x,:y,:d).new
      main.x     = 0
      main.y     = 0
      main.d     = Image.load("./img/back/main.png")
      main2      = main.clone
      main2.x    = 0
      main2.y    = main.d.height      
      # const で 初期化したい
      Yuyuko.client_x      = 20
      Yuyuko.client_y      = 20
      Yuyuko.client_width  = 460
      Yuyuko.client_height = Window.height - 40
      o.miko({ sym_uniq: :background
        }) do |o|

#            Window.drawEx 0 , 0 , main , z: - 10
            
            [ main , main2 ].each do | m |
              m.y += 1
              if m.y > Window.height
                m.y  = -m.d.height
              end
              Window.drawEx m.x  , m.y  , m.d , { z:-11 } 
            end if hs[:main] != :non

            hhs = { z: 10 }

            Window.drawEx 0 , 0 , top , hhs
            Window.drawEx 0 , 0 , left , hhs

            Window.drawEx 480 , 0 , right , hhs
            Window.drawEx 0   , 460 , bottom , hhs

            Window.drawEx 480 , 0 , right_menu , hhs
            Window.drawEx 480 , 230 , right_logo , hhs

        end # d
    end # background

    def fdraw o , hs = Hash.new

      Window.drawFont 550 ,  450, "fps #{Window.fps}" , Yuyuko.font , { z:40 , alpha: 200 , color: [220,170,220] }
      begin
        Window.drawFont 500 ,  050, "tt #{$Patchouli.user.tokuten}" , Yuyuko.font , { z:40 , alpha: 200 , color: [220,170,220] }
        Window.drawFont 500 ,  100, "zanki #{$Patchouli.user.zanki}" , Yuyuko.font , { z:40 , alpha: 200 , color: [220,170,220] }
        Window.drawFont 500 ,  130, "life  #{$Patchouli.user && $Patchouli.user.life}" , Yuyuko.font , { z:40 , alpha: 200 , color: [220,170,220] }
        Window.drawFont 500 ,  160, "sp #{$Patchouli.user.spell}" , Yuyuko.font , { z:40 , alpha: 200 , color: [220,170,220] }

      rescue

      end
    end # f

#--------------- 


    def user_deth o
        o.miko do |o|
          case o.c
          when 100
            Patchouli_User::User::default   Patchouli_Knowledge.miko
            o.delete
          end
        end
    end
    def user_deth2 o
        o.miko do |o|
          case o.c
          when 100
            Patchouli_Knowledge.miko.miko do
              Window.drawFont2 100, 300 , "game_over__"
            end # o
            o.delete_lazy 10
          end # case 
        end # u
    end
      
    def message_proc o
      
      case $Scarlet.message[:field].shift
     
      when :boss_haiti_ok
         # + effect?
         # boss オブジェクトからとんでくるメッセージ
         # 会話開始する
         kaiwa_interrupt o
         
      #あってもなくても、どっちでもいいような、感じの start end
      when :kaiwa_start
        kaiwa_start o
      when :kaiwa_end
        kaiwa_end o  
      when :user_deth
        # Nazrin
        user_deth o
      when :user_deth2
        # Nazrin
        # ざんき　０になったとき
        user_deth2 o
      when :boss_deth , :stage_clear
        stage_clear o
      end # 
    end # msg


# -----------------------------------
#
# logo_create
#
# field によって画像を変えられるようにする
# 
#
# -----------------------------------

    def logo_create o
      alpha  = Yukarin.count_limit_create 50  , 240 , 1
      alpha2 = Yukarin.count_limit_create 240 , 0   , -1
      hhs = ->{
        ({ alpha: alpha.call })
      }
      hhs2 = ->{
        ({ alpha: alpha2.call })
      }
      img  =  Image.load("img/field_logo.png")
      o.miko({ x:300 , y:300 })do |o|
         case o.c 
         when 1..300
          Window.drawEx o.x , o.y , img , hhs.call
         when 300..600
          Window.drawEx o.x , o.y , img , hhs2.call   
          o.y += 0.1 
         when 700
           o.delete
         end
      end
    end

# --------------------------------------------------------------------
#
#  stage_clear  o
#   もう少し柔軟性あげる
#
#
#
# --------------------------------------------------------------------
  def stage_clear o

    xxx , yyy = Lumia.get_client_xy_center Image.new(50,50,[100,200,220])
    o.miko({ sym: :effect , x: xxx , y: yyy , d: Image.new(50,50,[170,150,190]) ,
    z: 11 ,
    alpha:   ({ type: :default, start: 60 , limit: 170 , add: 1  }) ,
    rot:     ({ type: :default, start: 0 , limit: 400 , add: 1.3  }) ,
    scalex:  ({ type: :default, start: 1 , limit: 25 , add: 0.1  }) ,
    scaley:  ({ type: :default, start: 1 , limit: 25 , add: 0.1  }) ,
    }) do |o|
      ccc = o.c
      case ccc
      when 50
#            fhs = ({ z:12 , alpha: 220 , color:[230,220,230], })
#            Window.drawFont 50 , 100 , "crear..." , Yuyuko.font2 , fhs
      when 100
        o.miko({ sym: :effect , x: 50 , y: 10 , d: "--stage--crea--" , font: Yuyuko.font2_70 ,
        z: 12 ,
        alpha:   ({ type: :default, start: 120  , limit: 220 , add: 3  }) ,
        scalex:  ({ type: :default, start: 1 , limit: 1  , add: 0.01  }) ,
        scaley:  ({ type: :default, start: 0.7 , limit: 1  , add: 0.01  }) ,
        }) do |o|
          case o.c
          when 0..20
             o.y += 1
          end # c
        end # o
      when 10
        [
         50 , 150 , "とくてん"  ,
         50 , 220 , "すてーたすA"  ,
         50 , 290 , "すてーたすB"  ,
        ].each_slice(3) { | x , y , str |
          o.miko({ sym: :effect , x: x , y: y , d: str , font: Yuyuko.font2_60 ,
          z: 12 ,
          alpha:   ({ type: :default, start: 120  , limit: 220 , add: 3  }) ,
          scalex:  ({ type: :default, start: 1 , limit: 1  , add: 0.01  }) ,
          scaley:  ({ type: :default, start: 0.7 , limit: 1  , add: 0.01  }) ,
          }) do |o|
            case o.c
            when 0..20
               o.y += 1
            end # c
          end # o
        }
      end # case
      
      if ccc > 20
        # 全
        if Input.vkeyPush? :vk0
          $Scarlet.message[:field_top] << :next
          o.fade_out({ z: 55 ,
           destruct: ->{
                o.search_up(/field/).delete
             }
          })

        end # if
      end # if
    end # o
  end # stag_clear def

# -------------------------------------------------
# オーバーライドして使う･･･?
#
    def kaiwa_start o
      
    end
    
    def kaiwa_end o
      
    end
#
#
# -------------------------------------------------------
     
    def kaiwa_proc o , hs
      data = hs[:data].flatten.each_slice(4).to_a
      yuyukosama_png = hs[:chara_A]
      reimu_png      = hs[:chara_B]
      text_box       = Image.new(400,170, [100,150,220,180])# Image.load("img/text_box.png")
      o.miko({ sym: :interrupt }) do |o|
# --------------------------- phase_count is stop no ta me no -------------------
#
        $Scarlet.message[:phase_count] << :interrupt
#
# --------------------------------------------------------------------------------        
        o.Init do
          $Scarlet.message[:field] << :kaiwa_start
          o.destruct = ->{
            $Scarlet.message[:field] << :kaiwa_end
          }
                      
# -------------------- chara_ create_ A ---------------------
#
#
# -----------------------------------------------------------
          o.miko({ sym: :effect_yuyukosama , 
            x: 500 , y: 100 , d: Yuyuko.dd ,
          }) do |o|
            if o.x > 260
               o.x -= 2
            end
            Window.drawEx o.x , o.y , yuyukosama_png , alpha: 220 , z: 12 
          end
# -------------------- chara_ create_ B ---------------------
#
#
# -----------------------------------------------------------
          o.miko({ sym: :effect_reimu , 
            x: -100 , y: 100 , d: Yuyuko.dd ,
          }) do |o|
            if o.x < -70
               o.x += 2
            end
            Window.drawEx o.x , o.y , reimu_png , alpha: 220 , z: 12 
          end # r m
# ----------------------
        end # init
#
#
#
# --------------- kaiwa intrurput main --------------
#
#
#
#
# ---------------------------------------------------
        Window.drawEx   40 , 300, text_box , z: 13 

        case o.c
        when 0..2
          next
        end
        if Input.vkeyPush? :vk0
          data.shift
        end
        chara , png , lmd , text = data.first
        if data.not_empty?
          hhs  = {alpha: 220 , z: 14}
          case chara
          when "yuyuko"
             hhs[:color] = [140,140,220] 
             yuyukosama_png = png
          when "reimu"
             hhs[:color] = [200,170,130] 
             reimu_png = png
          end
          Window.drawFont 50, 300 , text , Yuyuko.font5_40 , hhs 
        else

          $Scarlet.message[:boss] << :kaiwa_end
          o.delete
        end

      end # o
    end # d



# ------------------------------------------------------------
#
#  phase_count_main  色んな割り込みを行う
#
#  格 Field では def phase_count_main_sub でゲーム進行を定義する事
#
#
#   
# ------------------------------------------------------------
     
    def phase_count_main o
# -----------------------------------------------------
#  phase_count を一時停止
#
#
#-------
      case $Scarlet.message[:phase_count].shift
      when :interrupt
        $Scarlet.message[:phase_count] -= [ :interrupt ]
        return
      end
      #
      # 停止中じゃなければ　phase_count 実行
      #
      phase_count_main_sub o
    end
      
      
        
end # modle
# ---------------------- field module end ----------------------------
#
#
#
#---------------------------------------------------------------------