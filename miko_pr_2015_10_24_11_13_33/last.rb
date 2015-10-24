# -*- encoding: UTF-8 -*-
# ruby 1.9.3p448 (2013-06-27) [i386-mingw32]
#
#
#
require "dxruby"
require "dxrubyex"
require "ostruct"
require "yaml"
#require "Kconv"
#require "pp"
#
# gem liblary
require 'enumerable/lazy'
#require 'win32/clipboard'
#require "ap"
# ------------- DEBUG -----------------------
# $__DEBUG_MODE__ =  File.file?("./__DEBUG_MODE__")
# dir set
Dir.chdir File.dirname(File.expand_path("../pr6",__FILE__))+"/"
#Dir.chdir File.dirname(File.expand_path(__FILE__))+"/"
#Dir.chdir File.dirname($0) + "/"
# p Dir.pwd
dir = "./"
# ---------------- entory ------------------
#
# ------------- expansion -------------------------
require dir + "ex/ruby_ex"
require dir + "ex/ruby_ex_x"
require dir + "ex/ruby_ex_kotohime"
require dir + "ex/dxruby_ex"
# ------------- const --------------
require dir + "const"
# ------------- expansion -------------------------
require dir + "ex/key"
require dir + "ex/Scarlet"
# ------------------ header ---------------
#require dir + "ex/compile"
require dir + "yk/Lumia"
require dir + "yk/Yukarin"
#require dir + "yk/Yakumo_ran"
#require dir + "yk/Yakumo_chen"
require dir + "yk/__Yakumo_yukari___"
require dir + "yk/tree_task_search"
#require dir + "yk/tree_task"
require dir + "yk/Yuyuko"
require dir + "yk/Mikomiko"
# ------------ project src ------------
# Pattern Hedder
require dir + "in/Patchouli_Knowledge"
#
require dir + "in/field"
require dir + "in/Title"
require dir + "in/Menu"
require dir + "in/Exit"
require dir + "in/Irast"
require dir + "in/Field"
require dir + "in/Field_1"
require dir + "in/Field_2"
require dir + "in/Field_nil"
require dir + "in/Ending"
require dir + "in/Staff_roll"
require dir + "in/Game_over"
# Pattern
require dir + "in/User_p"
require dir + "in/Enemy_p"
require dir + "in/Enemy_p_boss0"
require dir + "in/Effect_p"
require dir + "in/Item_p"
# template
require dir + "in/Menu_pattern_0"
require dir + "in/Menu_pattern_1"
require dir + "in/Menu_pattern_2"
require dir + "in/Menu_pattern_3"
require dir + "in/Menu_pattern_4"
require dir + "in/Menu_pattern_5"
# next project
require dir + "next/window_system"
# ----------- debug ------------

[
  /Field_nil/           , ->o{ Tewi::Field.new o } ,
  /Patchouli_Knowledge/ , ->o{ Tewi::Field.new o } ,
  /window_system/       , ->o{ Tewi::Window_system.new o } ,
  /Menu_pattern_0/      , ->o{ Tewi::Menu_pattern_0.new o } ,
  /Menu_pattern_1/      , ->o{ Tewi::Menu_pattern_1.new o } ,
  /Menu_pattern_2/      , ->o{ Tewi::Menu_pattern_2.new o } ,
  /Menu_pattern_3/      , ->o{ Tewi::Menu_pattern_3.new o } ,
  /Menu_pattern_4/      , ->o{ Tewi::Menu_pattern_4.new o } ,
  /Menu_pattern_5/      , ->o{ Tewi::Menu_pattern_5.new o } ,
].each_slice(2) do | r , new |
  next if not $0 =~ r
  $Create_mode = true
  Yuyukosama.new.Main do | o |
     o.Loop :field do |o|
       new.call o
       o.Code do
       end
     end
     o.Code do end
  end
end

# require dir + "scene/title"
# require dir + "scene/menu"
# require dir + "scene/exit"
# require dir + "scene/field"
# require dir + "scene/option"
Dir[dir+"AnneRose/*.rb"].each do |m|
  require m
end

#require dir + "scene/"
#require dir + "scene/"

# lib
module Create_Generator
	class << self
		def extended o
      o.var_add :Message_Q , :sounds , :bgms , :fonts , :imgs
      o.Message_Q = []

			o.var_add :uniq_sym , :static_logic
			o.uniq_sym     = c_uniq_sym
			o.static_logic = c_static_logic
		end
		def c_uniq_sym
		  _=0;->{ return "#{__method__}_#{_+=1}".to_sym }
		end
  	def c_static_logic
  	  _={};->{ _[caller.to_s] ? false : _[caller.to_s] = true }
  	end
	end
end

# meta#
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------

# $Scarlet.TOP_SYM
Tree_Diagram.new.Main :top_yuyu do | o |
#  $Scarlet.TOP_NODE = o
#  Yuyuko.TOP_NODE = o
  o.Code do
    if o.task.empty?
      o.Flandoll << :title
    end
    case o.Flandoll.pop
  when :title
    o.Loop :title do |o|
       AnneRose::Title.new o
       o.Code do
         case o.Flandoll.pop
  when :menu
    o.Loop :menu do |o|
       AnneRose::Menu.new o
       o.Code do
         case o.Flandoll.pop
  when :field
    o.Loop :field do |o|
       AnneRose::Field.new o
       o.Code do
         case o.Flandoll.pop
        when :ending
          o.Loop :ending do |o|
             AnneRose::Ending.new o
             o.Code do end
          end
end
end
end         when :option
          o.Loop :option do |o|
             AnneRose::Option.new o
             o.Code do end
          end
        when :exit
          o.Loop :exit do |o|
             AnneRose::Exit.new o
             o.Code do end
          end
end
end
end
end
end
end
end
end
end


# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------
exit


# ----------- project const -------------------
#
# require "__tewi/stg0req"  if $0 ==__FILE__
Tree_Diagram.new.Main  $Scarlet.TOP_SYM = Yuyuko.top_sym do | o |
  $Scarlet.TOP_NODE = o
   Yuyuko.TOP_NODE = o
   o.Code do
    if o.task.empty?
     o.Flandoll << :title
#     $Scarlet.flandoll << :bug
    end
    case o.Flandoll.pop
    when :title
        o.Task_Loop :title_loop do | o |
          AnneRose::Title.new o
          o.Code do
            case o.Flandoll.pop
            when :menu
              o.Loop :menu do |o|
                 AnneRose::Menu.new o
                o.Code do
                  case o.Flandoll.pop
                  when :field
                    o.Loop :field do |o|
                      AnneRose::Field.new o

                      o.Code do
                        case $Scarlet.flandoll.pop
                        when :ending
                          o.Loop :ending do |o|
                            Tewi::Ending.new o
                            o.Code do end
                          end # loop
                        end #case
                      end #code
                    end # loop
                  when :option
                    o.Loop :option do |o|
                      AnneRose::Option.new o
                      o.Code do end
                    end
                  when :exit
                    o.Loop :exit do |o|
                      AnneRose::Exit.new o
                      o.Code do end
                    end #
                  end # case
                end # code
              end # loop
           end # title_case
         end # menu code
      end # taskloop
    end #case
  end #
end #
#if nil
#exit


Tree_Diagram.new.Main Yuyuko.top_sym do | o |
       Yuyuko.TOP_NODE = o
#   Yuyuko.TOP_NODE = o # def main �ˤ�����

   o.Code do
    if o.task.empty?
#    $Scarlet.flandoll << :test
     $Scarlet.flandoll << :title
#     $Scarlet.flandoll << :bug
    end
    case $Scarlet.flandoll.pop
      when :title
        o.Loop :title do | o |
          Tewi::Title.new o
          $Scarlet.flandoll << :ok
          o.Code do
            if :ok == $Scarlet.flandoll.pop
              o.Loop :menu do |o|
                Tewi::Menu.new o
                $Scarlet.flandoll << :start
                o.Code do
                  case $Scarlet.flandoll.pop
                  when :start
                    o.Loop :field do |o|
                      Tewi::Field.new o
#                       $Scarlet.flandoll << :ending  #
                      o.Code do
                        case $Scarlet.flandoll.pop
                        when :ending
                          o.Loop :ending do |o|
                            Tewi::Ending.new o
#                            $Scarlet.flandoll << :staff_roll  #
                            o.Code do
                              case $Scarlet.flandoll.pop
                              when :staff_roll
                                o.Loop :staff_roll do |o|
                                  Tewi::Staff_roll.new o
                                  o.Code do
                                  end # code
                                end # l
                              end # case
                            end # code
                          end # loop
                        when :game_over
                          # ̤����
                          o.Loop :game_over do |o|
                            Tewi::Game_over.new o
                            p :Game_over_new
                            o.Code do
                            end
                          end # l

                        end # case
                      end # c
                    end # l
                  when :irast
                    o.Loop :Irast do |o|
                      Tewi::Irast.new o
                      o.Code do
                      end
                    end
                  when :sound
                  when :config
                  when :exit
                    o.Loop :Exit do |o|
                      Tewi::Exit.new  o
                        o.Code do
                      end #
                    end # code
                  end # case
                end # code
              end # lp
            end # if
          end # c
        end # lp
      when :menu
      when :bug

      when :test
        o.Loop :title do | o |

         nyan = Class.new do
            attr_accessor :x , :y , :d
            def initialize x,y,d
              @x = x
              @y = y
              @d = d
            end
            def func
              Window.drawEx @x , @y , @d
              @x += Input.x * 5
              @y += Input.y * 5
            end
         end
         aaa  = nyan.new 50,50,Image.new(40,40,[200,150,200])
         zz = Hatate::Imprint.new


          o.Code do
           zz.draw aaa.x  ,  aaa.y  ,  Image.new(80,80,[100,150,200])
           aaa.func
          Window.drawFont2 100, 100 , "test"
          if Input.keyPush?(K_X)
            o.Loop :nyan do | o |
            end
          end
          if Input.keyPush?(K_Z) || rand(10) == 0
            o.up.miko({ sym: :effect ,
              x: rand(620) , y: 100 , d: Image.new(60,rand(220)+1,[100,200,100]) ,
              angle: 90 , speed: 1 ,
              alpha:  ({ type: :default, start: 50 , limit: 255 , add: 1  }) ,
              rot:    ({ type: :default, start: 0  , limit: 900 , add: 1  }) ,
            }) do | o |
              o.Init do
                o.delete_lazy 240
                o.remi = Hatate::Imprint.new
              end
             o.remi.draw o.x  ,  o.y  ,  o.d
            end
         end # if
        end # co
      end # lp
     end # case

  end # c

end # tr



# ------------------------ main ------------------------------
Yuyukosama.new.Main Yuyuko.top_sym do | o |
  a = Lumia.Image_load_miko "./img/shot/0"
  p a
  cc = Yukarin.count_loop_create 0 , 20*a.size , 1
  o.Code do
     Window.draw 0 , 0 , a[cc.call / 20]

      o.Task :sym ,{x:4} do | o |
        o.Code do
           p o.x
        end # code
      end if Input.keyPush?(K_Z)


#    Window.loop2 do
#       Window.drawFont 100,100,"sfs" ,Yuyuko.font
#    end
  end
end
