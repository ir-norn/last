# -*- encoding: UTF-8 -*-
# ruby 1.9.3p448 (2013-06-27) [i386-mingw32]
#
require "dxruby"
require "dxrubyex"
require "yaml"

# ------------- DEBUG -----------------------
# $__DEBUG_MODE__ =  File.file?("./__DEBUG_MODE__")
Dir.chdir File.dirname(File.expand_path("../pr6",__FILE__))+"/"
# p Dir.pwd
dir = "./"
# ---------------- entory ------------------
# ------------- expansion -------------------------
require dir + "ex/ruby_ex"
require dir + "ex/dxruby_ex"
# --- Lib ---
# lib
module Create_method_uniq_sym
	class << self
		def extended o
			o.var_add :uniq_sym
			o.uniq_sym     = c_uniq_sym
		end
		def c_uniq_sym
		  _=0;->{ return "_uniq_#{_+=1}".to_sym }
		end
  end
end
module Create_method_static_logic
	class << self
    def extended o
			o.var_add :static_logic
			o.static_logic = c_static_logic
		end
  	def c_static_logic
      p :c_static_logic
  	  _={};->{ _[caller.to_s] ? false : _[caller.to_s] = true }
  	end
	end
end
# --- const --
require dir + "const"
# ------------- task -------------------------
require dir + "yk/tree_task_search"
require dir + "yk/Yuyuko"
# -- scene lib
# -- scene
Dir[dir+"AnneRose/*.rb"].each do |m|
  require m
end

require dir + "tree"

exit
# meta#
# --------------------------------------------------------------------
# --------------------------------------------------------------------
# --------------------------------------------------------------------

# $Scarlet.TOP_SYM
Tree_task.new.Main :AnneRose_main do | o |
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
  when :menu , :MSG_CODE1
    o.Loop :menu do |o|
       AnneRose::Menu.new o
       o.Code do
         case o.Flandoll.pop
         when :return
           o.up.delete
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
