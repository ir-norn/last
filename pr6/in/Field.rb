# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__
require "./in/field_old"
require "./in/field_module"

# ---------------------------------------- Field main----------------------------------------
#
#
#
#
# -------------------------------------------------------------------------------------------

module Tewi
  class Field
    include Patchouli_Knowledge
    include Field_module
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      o.miko({ sym: :field_1 }) do | o |
      end # o

    end # init2
    def next_scene o 
    end
    def init o
      scene = []
      o.miko({ sym: :field_top }) do | o |
        o.Init do
          
          #
          #
          # pattern　使う為の重要な初期化
          #
          Patchouli_Knowledge.miko_set o
          Patchouli_Knowledge.user_set o
          #
          
          if $Create_mode
            Tewi::Field_nil.new o
          else
            field_create o
          end

          scene << ->{ Tewi::Field_1.new o }
#          scene << ->{ Tewi::Field_2.new o }
          scene << ->{
#            p "エンディングへ行くためのシーン生成"  if $de
            $Scarlet.frandoll << :ending
           }

        end
        case $Scarlet.message[:field_top].shift
        when :next
          scene.shift.call
        end
      end # o
    end
    
    #
    #
    # ローディング画面はさんでもいい
    #
    def field_create o
      $Scarlet.message[:field_top] << :next
    end
    


  end # Field

end # m



















