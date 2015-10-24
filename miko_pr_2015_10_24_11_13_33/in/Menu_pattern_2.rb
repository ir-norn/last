# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__



module Nyan
  class Menu_pattern_2
    def initialize hs = Hash.new
      @sstr           = hs[:sstr ]     || [ *"a".."z" ].take(10).zip(["__"].cycle).dmap.join
      @remi           = hs[:remi ]     || Yukarin.key_focus_create2
      @key_wait0      = hs[:key_wait0] || 6
      @key_wait1      = hs[:key_wait1] || 4
      @focus          = hs[:focus]     || 0
      @space          = hs[:space]     || 20
      @str_p          = hs[:str_p]
      @font           = hs[:font ]     || Yuyuko.font3_20
      @x              = hs[:x    ]     || 50
      @y              = hs[:x    ]     || 120
      @fx             = hs[:fx   ]     || 4
      @hss1           = hs[:hss1 ]     || { :z => -2 ,  :alpha => 230 , :color => [220,200,220] }  
      @hss2           = hs[:hss2 ]     || { :z => -2 ,  :alpha => 230 , :color => [100,100,200] } 
      @fx             = hs[:fx   ]
      @type           = hs[:type ]
      @type_draw      = hs[:type_draw ] || :default
      
      @padding_top    = hs[:padding_top    ] || 0
      @padding_bottom = hs[:padding_bottom ] || 0
      
      @remi_f =       
      case @type
      when :tate
        ->{ @focus = @remi.call  @sstr.size , K_UP   , K_DOWN  , @focus , @key_wait0 , @key_wait1 }
      when :yoko
        ->{ @focus = @remi.call  @sstr.size , K_LEFT , K_RIGHT , @focus , @key_wait0 , @key_wait1 }
      else
        p "__menu_type_err__" , @type
      end
      
      @sym_uniq_hs =  Hash.new
      if hs[:sym_uniq] 
        @sym_uniq_hs = { :sym_uniq => hs[:sym_uniq] }
      end

    end
    
    def create o
  
        o.miko( @sym_uniq_hs ) do | o |
        
          @remi_f.call
   	      @sstr.each_with_index do| m , i |
      	     xy   = [ @x      ,  @y + i * @space ]
      	     xy_p = [ @x - 20 ,  @y + i * @space ]
      	     if @type == :yoko
      	       xy.reverse!
      	       xy_p.reverse!
      	     end
    	       if i == @focus
    	            Window.drawFont( *xy_p , @str_p   , @font , @hss1 ) if @str_p
    	            Window.drawFont( *xy   , m        , @font , @hss1 )
    	       else Window.drawFont( *xy   , m        , @font , @hss2 )
    	       end
    		  end # e
          ok o , @focus
          ce o , @focus
          
        end # miko
     
    end # df
    
    def ok o , focus
      if Input.keyPush? K_Z
        p :ok , focus
      end
    end
    
    def ce o , focus
      if Input.keyPush? K_X
        p :ce , focus
      end
      
    end

  end # c
end # m


# ---------------------------------------- Menu_pattern_2 ----------------------------------------
module Tewi
  class Menu_pattern_2
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      a = Nyan::Menu_pattern_2.new({
        sstr: %w!aa bb cc dd ee!   ,
        type: :tate ,
      })
      
      a.create o

      o.miko({ sym: :menu_pattern_2 }) do | o |
        
      end # o
    end # init2

    def init o
        
#      o.fade_in
      o.miko({ sym: :menu_pattern_2 }) do | o |
#        Window.drawFont(50,  10, "--Menu_pattern_2--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # Menu_pattern_2

end # m
