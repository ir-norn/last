# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- Field_2 ----------------------------------------
module Tewi
  class Field_2
    include Patchouli_Knowledge
    include Field_module
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :field_2 }) do | o |
        
      end # o
    end # init2

    def init o
        field_2_create o
#      o.fade_in
      o.miko({ sym: :field_2 }) do | o |
        Window.drawFont(50,  10, "--Field_2--"   , Yuyuko.font)
        
      end # o
    end # init


    def field_2_create o
  #      o.fade_in
      o.miko({ sym: :field }) do | o |
        o.Init do
          background_create o
          p :field2
        end
        Window.drawFont2 100,50 , "--field2--"
        Nazrin.collision_set_check o
        fdraw o
        field_key o
        message_proc o
  ##--------------------------------##
        phase_count o
      end # o
    end
  

    def phase_count o
        ccc = o.c
        if @__user_create_init.nil?   # debug 
          @__user_create_init ||= true
            User::default  Patchouli_Knowledge.miko
        end

        case ccc
        when 40003
          Enemy::e3 o
        when 1
          $Scarlet.frandoll << :ending
          # user
        when 20
          logo_create o
        end # case
        
    end

    
  end # Field_2

end # m
