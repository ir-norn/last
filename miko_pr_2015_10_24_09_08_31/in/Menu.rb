# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__


# ---------------------------------------- Menu ----------------------------------------
class Menu_create
	attr_accessor :x , :y , :font , :space
	attr_accessor :select_color
	attr_accessor :select_color_no
	attr_accessor :focus_img
	attr_accessor :focus_padding
	def initialize hs = Hash.new
    @font  = hs[:font]  || Yuyuko.font
    @space = hs[:space] || 40
		@type  = hs[:type]  || :tate
		@x     = hs[:x]     || 100
		@y     = hs[:y]     || 100
		@vk    = Vk_Input.new "profile0"
		
		
    @remi  = Yukarin.key_focus_create2
    @sstr = hs[:sstr] || [ 
       "__start" , "__irast"  , "__exit" ,
      ]
	end
  def draw o
    
  	 sstr = @sstr
  	 remi = @remi

  	 case @type
  	 when :yoko
   	 when :tate
	     n = remi.call  sstr.size , :vk_up  , :vk_down , n , 6 , 50
	     font_color = Yuyuko.font_select_no_color
	     sstr.each_with_index do| m , i |
	       if i == n
	            Window.drawFont(@x-40 ,  @y+i*space, ">>"    , font , { color: font_color , } )
	            Window.drawFont(@x    ,  @y+i*space, m.to_s  , font , { color: font_color , } )
	       else Window.drawFont(@x    ,  @y+i*space, m.to_s  , font , { color: font_color , } )
	       end
		  end # e
		   if @vk.vkeyPush? :vk0
		     ok
		     case n 
		     when 0
		       o.miko do |o|
		         case o.c
		         when 1
		            o.miko do
                  @__menu_font ||= Font.new(70 , "Comic Sans MS")
                  font = @__menu_font
                  Window.drawFont(50,  400, " N o w l o a d i n g ..." ,
                    font , color: [130,130,220] , alpha: 150 )

  		         end
		         when 100
               menu_fade_out o
		         when 200
    		       $Scarlet.frandoll << :start		           
 	           end
		       end
		     when 1
		       $Scarlet.frandoll << :irast
		       :irast
		     when 2
		       $Scarlet.frandoll << :exit
		     end
		   end
		   if @vk.vkeyPush? :vk1
#		     n = sstr.size
	 	     ce
 		   end
  	 when :sui
  	   
     end # case
  end
  def ok
  	p :ok
  end
  
  def ce
  	p :ce
#  	o.search_up( :title ).delete
  end

  
  def menu_fade_out o
      x =  0
      y =  0
      d = Image.new(Window.width,Window.height,[0,0,0])
      c = 0
      ret = nil
      o.miko({ x: x , y: y , d: d , z: +10 , sym: :effect, 
          alpha:  ({ type: :default, start: 0 , limit: 255 , add: 2.5  }) ,
        }) do | o |
         ret = o
         c += 2.5
         if c > 260
           o.delete
         end
      end # temp
  end
end


module Tewi
  class Menu
    def initialize o
#      init o
      init2 o

      $Scarlet.sound[:bgm_all_stop].call
      $Scarlet.sound[:title].play
      

    end # initialize
    def init2 o
      a =  Menu_create.new
      o.fade_in
      o.miko({ sym: :menu }) do | o |
        o.Init do
          img =  Image.load("img/title.png")
          o.miko do | o |
            Window.drawEx(100, 0, img , angle: 0 , alpha: 200 , blend: :add )
          end
        end
        a.draw o
      end # o
    end # init2

    def init o

      remi  = Yukarin.key_focus_create2
      sstr = [ 
        "start" , "irast" , "exit" ,
        ]


        
   	  vk = Vk_Input.new "profile1"
#      o.fade_in
      o.miko({ sym: :menu }) do | o |
         Window.drawFont(50,  10, "--Menu--"   , Yuyuko.font)
         font = Yuyuko.font
         space = 40
         o.x = 100
         o.y = 100
         n = remi.call  sstr.size , :vk_up   , :vk_down , n , 6 , 50
         
         if Input.keyDownWait? K_Z , 10
         	  p 3
         end
         
			  if vk.vkeyPush? :vk0
		  	 p 23
			  end


         font_color = Yuyuko.font_select_no_color
         sstr.each_with_index do| m , i |
           if i == n
             Window.drawFont(o.x-40 ,  o.y+i*space, ">>"  , font , { color: font_color , } )
             Window.drawFont(o.x , o.y+i*space, m.to_s    , font , { color: font_color , } )
           else
             Window.drawFont(o.x , o.y+i*space, m.to_s    , font , { color: font_color , } )
           end
         end

         if Input.keyPush?(K_X)
           o.search_up( :title ).delete
         end
      end # o
    end # init
    
  end # Menu

end # m



