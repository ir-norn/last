# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__
#
# 2015-10-24 06:14:49 +0900
# ---------------------------------------- exit ----------------------------------------
module AnneRose
  class Exit
    def initialize o
      o.Task :default_code do |o|  o.Code do
        $Scarlet.frandoll << :MSG_CODE1 if Input.keyPush? K_1
        $Scarlet.frandoll << :MSG_CODE2 if Input.keyPush? K_2
        o.up.up.delete                  if Input.keyPush? K_9

      end end
      init o
    end # initialize
    def init2 o

    end # init2

    def init o
      o.Task :nyaxxxx do |o|  o.Code do
           Window.drawFont(50,  10, "--exit--"   , $Scarlet.Font)
           if Input.keyPush? K_Z
             p o.up.up.up.scarlet
#             $Scarlet.frandoll << :exit
           end
		  end	end # o
    end # init

  end # exit
end # m
