# -*- encoding: UTF-8 -*-
# ---------------------------------------- editor ----------------------------------------
#
require "dxruby"
#require "./Lib/Scarlet"
require 'win32/clipboard'
#
require "kconv"
require "ostruct"

module Scarlet
  class << self
    def init ssss , mod , h
      h.each do | m , *h |
        next unless ssss.methods.include? m
        a = ssss.method( m ).call *h
        mod.define_singleton_method "#{m}".to_sym  do | *h , &block | a.method( m ).call *h , &block  end
        mod.define_singleton_method "#{m.to_s.delete('!?')}_".to_sym do a end
      end
    end
  end
# ----------------------------------------- //test------------------
  module Key
    def self.extended mod
      Scarlet.init self , mod , [
        *(self.singleton_methods - [__method__])
      ]
    end
    def self.keyDownWait? *h
      ru = Hash.new
      ru[:wait]       = 20
      ru[:loop_wait]  = 3
      ru[:keyhs]      = Hash.new
      a = OpenStruct.new ru
      a.define_singleton_method __method__ do | key , wait |
        loop_wait = wait
        lambda do
          if Input.keyDown? key
                keyhs[ key ] ||= 0
                keyhs[ key ] += 1
          else  keyhs[ key ]  = 0
          end
          return true if keyhs[ key ] == 1
          return wait < keyhs[ key ] && ( keyhs[ key ]%loop_wait == 0)
        end.call # lambda
      end
      return a
    end # kd

    def self.keyDownWait2? *h
      ru = Hash.new
      ru[:wait]       = 20
      ru[:owait]      = 50
      ru[:loop_wait]  = 3
      ru[:keyhs]      = Hash.new
      ru[:keyhs].default = 0
      a = OpenStruct.new ru
      a.define_singleton_method __method__ do | key , wait , owait |
        loop_wait = wait
        lambda do
          owkey = "ow_#{key}"
          if Input.keyDown?(key) 
            if ( keyhs[ owkey ] == 0 ) || ( keyhs[ owkey ] < owait )
              keyhs[ owkey ] += 1
              return Input.keyPush? key
            end
                keyhs[ key ] += 1
          else  keyhs[ key ]  = 0
                keyhs[ owkey ] = 0
          end
#          return true if keyhs[ key ] == 1
          return wait < keyhs[ key ] && ( keyhs[ key ]%loop_wait == 0)
        end.call # lambda
      end
      return a
    end # kd

  end
end

# keyDownWait
# keyDownWait2
#  を　使えるようにさせる
module Input
	extend Scarlet::Key
end




# ---------------------------------------- editor --------------------------------------------




  class Editor_system
    attr_accessor :x
    attr_accessor :y
#        attr_accessor :text
    def text ; @text end
    attr_accessor :y_draw_max
    attr_accessor :nokey
    attr_accessor :x_puts_max
    attr_accessor :keyDownWait
    attr_accessor :keyDownWait2

    def initialize
       @y_draw_max = 5
       @nokey      = []
       @x_puts_max = 999
       @keyDownWait   = 4  # Input.keyDownWait
       @keyDownWait2  = 10
       @x = 0
       @y = 0
       @font  = Font.new 30 , "FixedSys"
       @text =  [""]
       @point_view = 0 # 現在表示してる範囲のポインタ → 表示範囲 @point_view..y_draw_max
#           @point_x = 0
#           @point_y = 0

       @point_y = @text.size - 1
       @point_x = @text.last.size
       
       @keytable = keytable_init  # key init


    end


  
  def keytable_init
    key =[
      [ "K_SPACE"      ] ,
      [ "K_COMMA"      ] ,
      [ "K_PERIOD"     ] ,
      [ "K_SLASH"      ] ,
      [ "K_YEN"        ] ,
      [ "K_COLON"      ] ,
      [ "K_SEMICOLON"  ] ,
      [ "K_BACKSLASH"  ] ,
      [ "K_LBRACKET"   ] ,
      [ "K_RBRACKET"   ] ,
      [ "K_MINUS"      ] ,
      [ "K_AT"         ] ,
      [ "K_PREVTRACK"  ] ,
    ]
    key2 = [" "] + %w! , . / \\ : ; _ [ ] - @ ^ !
    key3 = [" "] + %w! < > ? |  * + _ { } = ` ~ !

    aru = ("a".."z").to_a
    suu = ("K_0".."K_9").to_a.rotate 
    suu2= ("0".."9").to_a.rotate
    suu3= (" \! \" \# \$ \% \& \' \( \) 0").split

    return [ ( ["K_"]*aru.size ).zip( aru.map(&:upcase) ).map(&:join) , suu , key ].flatten
    .zip( [:default].cycle ).zip( [aru , suu2 , key2 ].flatten )
    .zip( [:shift].cycle )
    .zip( [aru.map(&:upcase) , suu3 , key3 ].flatten )
    .zip( [:control].cycle ).zip( [""].cycle ) #    .zip( [":command"].cycle ).zip( ["<command>"].cycle )
    .flatten
  end

    def text_print
      @text.map do |m|
        m
      end.join"\n"
    end
    def text_puts ar
      [ar].flatten.each do | str |
#             @text[ @point_y + 1 ] = ""
         text_add str
         @point_y += 1
         @point_x  = 0
         @text.insert @point_y , ""
      end

    end
    def text_add str
#             p @text[@point_y] # str

#        p @text ,@point_y , @point_x , str
      @text[@point_y].insert @point_x , str
      @point_x += str.size
    end

    
    def draw_tips
      Window.drawFont( 0 , 20+350 , "@point_view"+@point_view.to_s , @font)
      Window.drawFont( 0 , 40+350 , "Line_y"+@point_y.to_s , @font)
      Window.drawFont( 0 , 60+350 , "Line_x"+@point_x.to_s , @font)
      Window.drawFont( 0 , 90+350 , "Lines"+@text.size.to_s , @font)
      Window.drawFont( 300 , 90+350 , "size" + 
        (@text.inject 0 do | a , m | a + m.size end).to_s ,
          @font)
    end

  def text_draw
    @text[ @point_view..(@point_view + y_draw_max ) ].each_with_index do | m , i |
      Window.drawFont(@x + 00, @y + i * @font.size , (i+@point_view).to_s , @font)
#            ms = m.size > 50 ? 50 : m.size
# たまに m が nil になってる  [ BUG ]  とれたかも toretakamo
      ms = m.size
      Window.drawFont(@x + 40, @y + i * @font.size , m[0..ms] , @font)
    end # @text
  end
  def text_draw_focus
    # FOCUS DRAW
    instance_exec @text[ @point_y ] do | c |
      n = @font.getWidth( c[0...@point_x] )
      pt = (@point_y - @point_view) > @y_draw_max ? @y_draw_max : @point_y - @point_view
      Window.drawFont(@x + 40 + n, @y + pt * @font.size , "|" , @font , { color: [0x7d,0xe1,0x75] } )
      Window.drawFont(@x + 41 + n, @y + pt * @font.size , "|" , @font , { color: [0x7d,0xe1,0x75] } ) 
    end # exec
  end

  def text_shuusei
    #
#          if ( @text.size == @point_y ) or ( @point_view + y_draw_max < @point_y )
    if ( @point_view + @y_draw_max < @point_y )
        @point_view = @point_y - y_draw_max
    end
    # HOME + CTL とかのときよばれる
    if  @point_view > @point_y
         @point_view = @point_y
    end
    # \n to push
    # 改行があったら次の配列にしたり、クリップボードからきた時の末尾の改行とったり、など
    @text.map! do | m |
      if m.include?("\n")
         next m.split("\n")
      end
      m.chomp!
      m
    end.flatten!
    
  end

  def text_kaigyou *ms
        return unless _ms_parse *ms

    if @point_x == @text[@point_y].size
       text_puts [""]
    else
      text_kaigyou_sub
    end
  end
  def text_kaigyou_sub
    tt = @text[@point_y][ @point_x..-1 ]
    @text.insert @point_y , @text[@point_y][ 0...@point_x ]
    @point_y += 1
    @text[@point_y] = tt
    @point_x     = 0 #text[@point_y].size
  end


  def text_right *ms
    return unless _ms_parse *ms

    if @text[@point_y].size > @point_x
      @point_x += 1
    elsif @text.size > @point_y+1
      @point_y += 1
      @point_x  = 0
    end
  end
  def text_left *ms
    return unless _ms_parse *ms
    if @point_x > 0
      @point_x -= 1
    elsif @point_y > 0
      @point_y -= 1
      @point_x  = @text[@point_y].size
    end
  end
  def text_up *ms
    return unless _ms_parse *ms
    if @point_y > 0
      @point_y -= 1
      if @point_x > @text[@point_y].size
         @point_x = @text[@point_y].size
      end
    end
  end
 def text_down *ms
   return unless _ms_parse *ms
   if @point_y+1 < @text.size
     @point_y += 1
     if @point_x > @text[@point_y].size
        @point_x = @text[@point_y].size
     end
   end
 end


 def text_delete *ms
   return unless _ms_parse *ms

   if @text[@point_y][@point_x]
     @text[@point_y][@point_x] = ""
   elsif @point_y+1 < @text.size 
     @text[@point_y] << @text.delete_at(@point_y+1)
   end
 end
 def text_backspace *ms
  return unless _ms_parse *ms

    tf = @point_x > 0
    @point_x -= 1 if @point_x > 0
    if @text[@point_y].size != 0
      if !tf
        if @point_y > 0 
          miu = @text[@point_y-1].size
          @text[@point_y-1] << @text[@point_y]
          @text.delete_at @point_y
          @point_y -= 1
          @point_x = miu # 0 # @text.last.size
        end
      else
        @text[@point_y][@point_x] = ""
      end # !tf
    else # @text_point_size != 0
      if @point_y > 0
        @text.delete_at @point_y
        @point_y -= 1
        @point_x = @text[@point_y].size
      end
    end
  end


  def text_paste *ms
    if _ms_parse *ms
      @text[@point_y].insert @point_x , Win32::Clipboard.data # .toutf8
    end
  end

  def text_page_down *ms
    if _ms_parse *ms
      4.times do
        @point_y += 1 if @point_y+1 < @text.size
      end
      @point_x = @text[@point_y].size if @point_x > @text[@point_y].size
    end
  end
  def text_page_up *ms
    if _ms_parse *ms
      4.times do
        @point_y -= 1 if @point_y > 0
      end
      @point_x = @text[@point_y].size if @point_x > @text[@point_y].size
    end
  end

  def text_page_home *ms
    @point_x = 0 if _ms_parse *ms
  end

  def text_page_home_ex *ms
    @point_y = 0 if _ms_parse *ms
  end

  def text_page_end *ms
    @point_x = @text[@point_y].size if _ms_parse *ms
  end

  def text_page_end_ex *ms
    @point_y = @text.size-1 if _ms_parse *ms
  end
  
  # message parce
  def _ms_parse ms , *h
    if ms.class == Proc
        ms.call
    else
      [ms , *h].flatten.each do | m |
        return false unless Input.keyDown?( m )
      end
    end
  end
  
  def key_msg
#   @nokey[0] = K_HOME
  # ------------------------------- Key  ------------------------------------------
      unless @nokey.include? :K_HOME_EX
        text_page_home_ex  ->{ Input.keyDown?( K_HOME ) && ( Input.keyDown?( K_LCONTROL ) or Input.keyDown?( K_RCONTROL ) ) }
      end
      unless @nokey.include? :K_END_EX
        text_page_end_ex   ->{ Input.keyDown?( K_END  ) && ( Input.keyDown?( K_LCONTROL ) or Input.keyDown?( K_RCONTROL ) ) }
      end
      text_page_home      K_HOME   unless @nokey.include? K_HOME
      text_page_end       K_END    unless @nokey.include? K_END
      text_page_up        ->{ Input.keyDownWait2?(  K_PGUP      , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_PGUP
      text_page_down      ->{ Input.keyDownWait2?(  K_PGDN      , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_PGDN
      text_left           ->{ Input.keyDownWait2?(  K_LEFT      , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_LEFT
      text_right          ->{ Input.keyDownWait2?(  K_RIGHT     , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_RIGHT
      text_up             ->{ Input.keyDownWait2?(  K_UP        , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_UP 
      text_down           ->{ Input.keyDownWait2?(  K_DOWN      , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_DOWN
      text_delete         ->{ Input.keyDownWait2?(  K_DELETE    , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_DELETE
      text_backspace      ->{ Input.keyDownWait2?(  K_BACKSPACE , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_BACKSPACE
      text_kaigyou        ->{ Input.keyDownWait2?(  K_RETURN    , @keyDownWait , @keyDownWait2 ) }  unless @nokey.include?  K_RETURN
      text_paste  ->{ 
         Input.keyDownWait2?(K_INSERT , @keyDownWait , @keyDownWait2) &&
       ( Input.keyDown?(K_LSHIFT) or Input.keyDown?(K_RSHIFT) ) }
      # marchi byte moji ire ru to bagu ru kara tyuui 

  end
  
  def key_msg2
      # moji nyuu ryoku 
      @keytable.each_slice( 7 ) do | ( key , *h ) |
        if eval"Input.keyDownWait2? #{ key } , 2 , 30"
          h = Hash[ *h ]
          if Input.keyDown?(K_LCONTROL) or Input.keyDown?(K_RCONTROL)
            next
            # command
          end 
          if Input.keyDown?(K_LSHIFT) or Input.keyDown?(K_RSHIFT)
            text_add h[:shift].to_s
          else
            text_add h[:default].to_s
          end
        end # if
      end # each
  
  end

  def editor_main
 
      text_shuusei
      
      draw_tips 
      text_draw 
      text_draw_focus 
      
      key_msg
      key_msg2
  end # def
  
end # ed class




ed = Editor_system.new
ed.nokey << K_RETURN
 ed.x_puts_max = 20
ed.y_draw_max   = 1
ed.keyDownWait  = 4
ed.keyDownWait2 = 9
ed.x = 40
ed.y = 20
#        ed.text_kaigyou_lambda = ->{  }

Window.loop  do
  ed.editor_main
  if Input.keyPush? K_RETURN
   p ed.text
  end
end

 
 
 
 