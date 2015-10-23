# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Field_1 ----------------------------------------
module Tewi
  class Field_1
    include Patchouli_Knowledge
    include Field_module
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      if $de
      else
#        $Scarlet.sound[:bgm_all_stop].call
#        $Scarlet.sound[:field_0].play
      $Scarlet.sound.play_ex :field_0
      end 
      
      o.miko({ sym: :field_1 }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in

      o.miko({ sym: :field }) do | o |
        $de and Window.drawFont(50,  10, "--Field_1--"   , Yuyuko.font)

        o.Init do
          background_create o
        end
        Nazrin.collision_set_check o
        fdraw o
        field_key o
        message_proc o
##--------------------------------##
        phase_count_main o
      end # o
        
    end # init



#----------------------------------------------------------------
#
#
#   メソッド名 変更禁止　phase_count_main_sub
#   field_module にて会話インタラプト
#----------------------------------------------------------------
    def phase_count_main_sub o

  # debug  code
       if $de
        if @__user_create_init.nil? 
          @__user_create_init ||= true
            User::default  Patchouli_Knowledge.miko
            Enemy::boss0_dummy o
#            kaiwa_interrupt o 
        end
       end
# --------------------------------------------
        ccc = o.c
#        Window.drawFont2 100,200 , ccc.to_s 
        nnn = $de ? 449989898 : 0
        case ccc + nnn
        when 40003
          Enemy::e3 o
        when 1
          if not $de
            User::default  Patchouli_Knowledge.miko
          end
          # user
        when 20
          logo_create o
        when 10 , 110 ,  210 ,  310
          Enemy::e0 o
        when 400 , 500 , 600 , 700 
          Enemy::e0_right o
        when 1000
          Enemy::e1 o , ({ x: 70})
        when 1200
          Enemy::e1 o , ({ x: 140})
        when 1400
          Enemy::e1 o , ({ x: 210})
        when 1600
          Enemy::e1 o , ({ x: 270})
        when 1800
          Enemy::e1 o , ({ x: 340})
        when 2000
          Enemy::e1 o , ({ x: 410})

        when 2600
          Enemy::e1 o , ({ x: 70})
          Enemy::e1 o , ({ x: 140})
          Enemy::e1 o , ({ x: 210})
          Enemy::e1 o , ({ x: 270})
          Enemy::e1 o , ({ x: 340})
          Enemy::e1 o , ({ x: 410})

        when 3200 , 3300 ,  3400 ,  3500
          Enemy::e0 o
        when 3400 , 3500 , 3600 , 3700 
          Enemy::e0_right o
         
        when 4500
#会話インタラプト     
# ボスを生成したら、ボス側からメッセージとばさせる
           Enemy::boss0_dummy o
#          Enemy::boss0 o
#       kaiwa_interrupt o  # debug
        end # 
        # case
    end # init
    
    def kaiwa_interrupt o
#      yuyukosama_A = Image.load("img/yuyuko_A.png")
#      yuyukosama_B = Image.load("img/yuyuko_B.png")
#      reimu_A      = Image.load("img/reimu_A.png")
#      reimu_B      = Image.load("img/reimu_B.png")

      reimu_A         = Image.load("img/yuyuko_A.png")
      reimu_B         = Image.load("img/yuyuko_B.png")
      yuyukosama_A    = Image.load("img/reimu_A.png")
      yuyukosama_B    = Image.load("img/reimu_B.png")


      #
      # 発言した時に、何かエフェクト出したい場合用のlambda
      lmd = ->{ }
      data = [
       ["yuyuko" , yuyukosama_A , lmd  , "ゆゆこさま\nてすと～" ] ,
       ["reimu"  , reimu_A      , lmd  , "れいむ\nてす"    ] ,
       ["yuyuko" , yuyukosama_B , lmd  , "ゆゆこさま\nすっす"   ] ,
       ["reimu"  , reimu_B      , lmd  , "れいむ\nてすっ"    ] ,
       ["yuyuko" , yuyukosama_A , lmd  , "ゆゆこさま\nにゃーーん" ] ,
      ]
      kaiwa_proc o , ({
        data: data ,
        chara_A: yuyukosama_A ,
        chara_B: reimu_A ,
      })
    end
 

    
  end # Field_1

end # m
