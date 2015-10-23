# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__


module Tewi
  class Field
    
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
  #        phase_count o
      end # o
    end
  
  end

end # tewi


