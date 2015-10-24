# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__


=begin

class Lumia_I____
  attr_accessor :yakumo # misiyou
  attr_accessor :img
  attr_accessor :nn
  def initialize img , nn = 20
     @nn  = nn
     @img = img

#     m = img.size
#     @yakumo = Yakumo_ran.lo({
#          start: 0 ,
#          limit: m ,
#          loopwait_ex_wait: 20 ,
#          loopwait_ex: [*0..m] ,
#          add: 1 ,
#        })   
  end
#  def dd
#    @img[ @yakumo.call ]
#  end

  def copy_new  
    self.class.new @img
  end
  
#
# 
# img[ @c ] ni suru
#
  def width
    @img.first.width
  end
  def height
    @img.first.height
  end
  def first
    @img.first
  end
  

end

=end


module Lumia
  class << self
    
    # セッターゲッター
    def create_sg v = 0
      [ ->n{ v = n } , ->{ v } ]
    end
    # repl
    def repl s
       (s =~ /\(.*?(\(.*)\)/ ? s.sub($1,(repl $1).to_s) : s).scan(/\((.*?)\s(.*)\)/).flatten.last.split.map(&:to_f).inject *(eval "[$1=~/[a-z|A-Z]/,:#{$1}].compact")
    end
    #  repl"(print (+ 8 9))"
    #  puts
    #  p repl"(* 8 9 5 5 5 5)"
    #  repl"(p (* 59 5 (* 4 (/ 10 6))))" 

    def recursion &b
      f = ->*n{ b[ *n , &f ] }
    end

    def y_combinator &b
      lambda do |f|
        lambda{|x|lambda{|y| f[x[x]] [y]}}[
          lambda{|x|lambda{|y| f[x[x]] [y]}}]
      end[ lambda{|f|lambda{|n| b[n , &f] }}]
    end

    def require file
      super File.dirname(__FILE__) + "/" + file
    end

    def extsplit s
#      s =~ /(.*)\.(.*)/
#      [ $1 , $2 ]
      [ File.basename(a , ".*") , File.extname(a) ]
    end
    def ary_nest a,n
      return a if n <= 0
      ary_nest [].push(a) , n-1
    end
    def ary2 a , b , c = 0
      (0...a).map do (0...b).map do c end end
    end

    def blockhit x1 , y1 , w1 , h1 , x2 , y2 , w2 , h2
      x1 + w1 > x2 && x1 < x2 + w2 && y1 + h1 > y2 && y1 < y2 + h2 
    end
    def work x , y , s , a
      x += (s * Math::cos(a * Math::PI/180 ))
      y += (s * Math::sin(a * Math::PI/180 ))
      [x , y , s , a]
    end

    def circle_pixel_hit x1,  y1,  w1,  h1,  r1, x2,  y2,  w2,  h2,  r2
      return (x1 - x2)*(x1 - x2) + (y1 - y2)*(y1 - y2) - r1*r2 <= 0
    end
    # ｗ/２ まで関数で計算する
    def circlehit2 x1, y1, w1, h1, r1, x2, y2, w2 , h2 , r2
      x1 = x1+w1/2
      y1 = y1+h1/2
      y2 = y2+h2/2
      x2 = x2+w2/2
      return ((x1-x2)**2+(y1-y2)**2)-((r1+r2)**2) <= 0
    end
    # ｗ / ２ を考慮しない
    def circlehit x1, y1, w1, h1, r1, x2, y2, w2 , h2 , r2
      x1 = x1+w1
      y1 = y1+h1
      y2 = y2+h2
      x2 = x2+w2
      return ((x1-x2)**2+(y1-y2)**2)-((r1+r2)**2) <= 0
    end

    def DegToRad x
      x*Math::PI/180
    end
    def RadToDeg x
      x*180/Math::PI
    end
    def firstatan x , y,   xxx, yyy
       RadToDeg( Math.atan2( yyy - y , xxx - x ))
    end

    def homing x , y , xxx , yyy , angle , as
      tmp = Lumia.homing_angle x , y, xxx , yyy
      angle += as if angle < tmp
      angle -= as if angle > tmp
      angle
    end
    #--------------------------
    def get_center xy, wh , len
       xy + ( wh * 0.5 ) - ( len * 0.5 )
    end

    alias move work
    alias homing_angle firstatan



# --------------------------------- 以下 dxrubyやライブラリ 依存 含む----------------------------
#
# 使わないほうがいいかも
#
# Nazrinに仕様を書く
#
#
    def rect_delete o
      unless Lumia.blockhit o.x , o.y , o.d.width , o.d.height ,
         -100 , -100 , Window.width+200 , Window.height+200
         o.delete
      end
    end



    def hit_check_box o , m
      o.x + o.d.width  > m.x && o.x < m.x + m.d.width &&
        o.y + o.d.height > m.y && o.y < m.y + m.d.height
    end

    def get_xy_center__SfS_fs  o , oo
        return get_xy_center_d o  , oo if oo.class == Image
               get_xy_center_d o  , oo.d
    end




    
    # -------------------------------
    # ちょっとテスト
    #
    def get_xy_center__  o , oo
      if oo.class == Image
        get_xy_center_d o  , oo 
      elsif oo.class == Lumia_I
        get_xy_center_d o  , oo.first
      elsif oo.class == Lumia_S  # String
         [ o.x , o.y , oo ]
#          get_xy_center_d o  , Image.new(d.size, d.get_witdh)         
#      elsif o.class == oo.class
#        get_xy_center_d o  , oo.d
      else
        get_xy_center_d o  , oo.d
#      p   o.class , oo.class
 #        p "err"
  #       p __method__
      end
    end
    def get_xy_center  o , oo
      
      if oo.class == Image
        oo_tmp =  oo 
#      elsif oo.class == Lumia_I
#       oo_tmp =   oo.first
#      elsif oo.class == String # Lumia_S  # String
#        return [ o.x , o.y , oo ]
      else
       oo_tmp =  oo.d
      end

      return get_xy_center_d o  , oo_tmp

      if o.class == Image
        o_tmp =  o 
      elsif o.class == Lumia_I
       o_tmp =  o.first
      elsif o.class == String # Lumia_S  # String
        return [ o.x , o.y , oo ]
      else
       o_tmp =  o.d
      end
      get_xy_center_d o_tmp  , oo_tmp
      
      
    end


    def get_xy_center_d  o , b
       [ o.x + ( o.d.width / 2 ) - ( b.width / 2 ) , o.y + ( o.d.height / 2 ) - ( b.height / 2 ) ]
    end
#    def get_xy_center_d x , y , d , ddd
 #      [ x + ( d.width / 2 ) - ( ddd.width / 2 ) , y + ( d.height / 2 ) - ( ddd.height / 2 ) ]
  #  end
    #
    # o　じゃなくdが渡された時に、型みて、dを辿ってメソッド実行するみたいな機構を、
    # Lumiaのほかのメソッド用にも作りたい
    #
    def get_client_xy_center o
        return get_client_xy_center_d o if o.class == Image
               get_client_xy_center_d o.d
    end
    def get_client_xy_center_d d
      [ Yuyuko.client_x + (Yuyuko.client_width  / 2 - d.width  / 2) , 
        Yuyuko.client_y + (Yuyuko.client_height / 2 - d.height / 2) ,
        ]
    end

    
    def get_homing_center o , v
      vx = v.x + v.d.width  / 2 - o.d.width  / 2
      vy = v.y + v.d.height / 2 - o.d.height / 2
      [ vx , vy ]
    end

    def get_wh dirname
       tmp = Image_load(dirname)
       return [tmp[0][0].width , tmp[0][0].height]
    end
  end
# Image と Sound の ロード関数を一緒にするための記述
  class << self
    # [[]]
    def Sound_load pas  ,  remi = "{wav}"
      __load( pas , Sound , remi )
    end
    # []
    def Sound_load_miko pas  , remi = "{wav}"
      __ImageSound_load_miko  pas  Sound  , patan
    end
    # Sound
    def Sound_load_alice pas  
      Image_load_alice pas , Sound
    end


    def __ImageSound_load_miko pas , remi , patan
      a = __load( pas , remi , patan )
      if a.empty? || a.class != Array
        p "#{__method__} pas is not directory #{pas} #{remi}"
        p caller
      end
      return  a.flatten - []  
    end
    
    # [[]]
    def Image_load pas  , remi = "{png,bmp,jpg,jpeg,gif}"
      __load( pas , Image , remi  )
    end
    # []
    def Image_load_miko pas , patan = "{png,bmp,jpg,jpeg,gif}"
       a = __ImageSound_load_miko  pas , Image  , patan
#       Lumia_I.new( a )
    end
    # Image
    def Image_load_alice  pas  ,  remi = Image
      a = __load( pas , remi , "{" + "#{File.extname(pas)}" + "}" )
      if a.empty? || a.class == Array
        p "#{__method__} pas is not file #{pas} #{remi}"
        p caller
      end
      return  a
    end

#    Lumia.i_yuyukosama
#    Lumia.i_miko
#    Lumia.i_alice
    
    alias i_yuyukosama Image_load
    alias i_miko       Image_load_miko
    alias i_alice      Image_load_alice


    def __load s , remi , patan
      stk = [[]]
      dir = []
      (@@load_sub___stack___ ||= lambda do | s , remi , patan |
         if dir.index s
            return stk[dir.index(s)] if File.directory?(s)
            return stk[dir.index(s)][0][0]
         end
         miko = stk[-1]
         if File.directory?(s)
             Dir["#{s}/*"].select do | m |
               File.directory? m
             end.each_with_index do | kd , k |
             miko << Dir[ "#{s}/#{k}/*."+patan ].map do | m |
  #               miko[k] = Dir[ "#{kd}/*."+patan ].map do | m |  # 0 1 2 じゃなく任意のフォルダ名
               remi.load m
             end
           end
           # 0 1 2 の フォルダがないときはこっちで位置次元配列
           if miko.empty? # 多次元配列読み込みじゃなければ、一次元配列読み込み
             miko << Dir[ "#{s}/*."+patan ].map do | m |
                remi.load( m )
             end
           end
           # 二次元配列return
           dir << s
           stk << []
           return miko
         elsif File.file?(s) 
           miko << []
           miko[0][0] = remi.load s
           dir  << s
           stk  << []
           return miko[0][0]
         end
         p "err2"
      end).call( s , remi , patan )
    end
  end
  
  def self.screenshot dir = "_screenshot"
     pwd = Dir.pwd
     Dir.chdir Yuyuko.TOPDIR
     Dir.mkdir( dir ) unless File.exist?( dir )
     file  =  dir + "/screenshot" + Time.new.strftime("%Y%m%d%H%M%S") + ".jpg"
     Window.getScreenShot( file )
     Dir.chdir pwd
     return file
  end


end

