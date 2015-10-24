# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Field_nil ----------------------------------------
module Tewi
  class Field_nil
    include Patchouli_Knowledge
    include Field_module
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
    end # init2
    
    def init o
        field_nil_create o
#      o.fade_in
      o.miko({ sym: :field_nil }) do | o |
      end # o
    end # init
    
    def field_nil_create o
      o.miko({ sym: :field }) do | o |
        o.Init do
          background_create o , main: :non
        end
        Nazrin.collision_set_check o  , de: :non
        fdraw o 
        field_key o
        message_proc o
        phase_count o
      end # o
    end
    
    def phase_count o
        ccc = o.c
        if @__user_create_init.nil?   # debug 
          @__user_create_init ||= true
            User::default   Patchouli_Knowledge.miko
        end
        case ccc
        when 1
          Enemy::boss1_test o
#          Enemy::tokuten_baramaki o
        when 1
          # user
        end # case
    end #df
    
  end # Field_
end # m






