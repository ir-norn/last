# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- window_system ----------------------------------------
module Window
  def self.dr o
    Window.draw o.x , o.y , o.d
  end  
end


module Tewi
  class Window_system
    def initialize o
      init o
      init2 o
    end # initialize
    def init2 o
      
      o.miko({ sym: :window_system }) do | o |
        
      end # o
    end # init2
    def click_b o , lumia_block
       o.miko do |o|
         if Input.mouseDown?(M_LBUTTON).!
           if Lumia.blockhit(*lumia_block ,  Input.mousePosX , Input.mousePosY , 1 , 1 )
             yield
           end # if
           o.delete
         end
         
       end
    end
    def default_windou o
      # bannpei
    end
    
    def win_task_bar_create o
    end
    

    def window_narabikae o , wintask , m
       wintask.delete m
       wintask.unshift m
    end

    def win_change o , wintask , e
      if wintask.first != e
        window_narabikae o , wintask , e
        e.msg << "WIN_CHANGE"
      end             
    end

    def os_shell_create o , wintask , hs = {}
      os_menu_bar = Image.new(Window.width,40,[220,200,200,220])
      win_task_d  = Image.new(100,30,[220,200,250,220])
      y = Window.height - os_menu_bar.height
      o.miko( sym: :shell ) do | o |    
        Window.draw 0 , y , os_menu_bar
        wintask.sort{|a,b| a.num <=> b.num }.
        each_with_index do | m , i |
          xx = 40 + (i*(win_task_d.width+50))
          yy = y + 5
          Window.draw     xx , yy , win_task_d
          Window.drawFont xx , yy , "#{m.sym}" , Yuyuko.font
          lumia_block = [ xx , yy , win_task_d.width , win_task_d.height ] 
          if Lumia.blockhit( *lumia_block , Input.mousePosX , Input.mousePosY , 1 , 1 )  
            if Input.mousePush?(M_LBUTTON) 
              click_b o , lumia_block do
                window_narabikae o , wintask , m
              end # break  
            end
          end # lu
        end # each
        # num 順序 each //
        
        next if wintask.empty?
        
        # win_z 順序 each

        f = wintask.first
        lumia_block = [ f.x , f.y , f.d.width , f.d.height ]
        mouse       = [ Input.mousePosX , Input.mousePosY , 1 , 1  ]

        kasanari = wintask.drop(1).map do | e |
          retty_block = [ e.x , e.y , e.d.width , e.d.height ]
          if Lumia.blockhit( *lumia_block , *mouse )  
            if Lumia.blockhit( *retty_block , *mouse)  
              next true
            end
          end # if win msg
          false
        end


        wintask.each do | e |
          retty_block = [ e.x , e.y , e.d.width , e.d.height ]
          next if not Lumia.blockhit( *retty_block , *mouse)  
#          next if not kasanari.any?.! # or f == e
          if Input.mousePush?(M_RBUTTON) 
             win_change  o , wintask , e
             e.msg << "M_RBUTTON_PUSH"
             break
          end
          if Input.mouseDown?(M_RBUTTON) 
             e.msg << "M_RBUTTON_DOWN"
          else
             e.msg << "M_RBUTTON_UP"
          end

          if Input.mousePush?(M_LBUTTON)
             win_change  o , wintask , e
             e.msg << "M_LBUTTON_PUSH"
             break
          end
          if Input.mouseDown?(M_LBUTTON) 
             e.msg << "M_LBUTTON_DOWN"
          else
             e.msg << "M_LBUTTON_UP"
          end
        end
#        end

        # 最上位のウィンドウにのみ
        if Input.keyPush? K_Z
          wintask.first.msg << "K_Z"
        end
        
        
      end # miko
    end
    
    def win_draw o , m
      Window.draw m.x , m.y , m.d
    end
    
    def window_create  o , wintask ,  hs = {}
      num    = hs[:num]
      x      = hs[:x] || 10
      y      = hs[:y] || 19
      width  = hs[:width] || 200
      height = hs[:height] || 150
      hs[:win_main] # window 構造体
      d           = Image.new(width,height,[200,200,240])

#      d = Image.load("img/yuyuko_A.png")

      tmp = Struct.new(:x,:y).new( x , y )
#      clicked = false
      o.miko( sym: :window , x: x , y: y , d: d ) do | o |    
        o.Init do
          wintask << o

          #
          # msg  の 受信について
          # 受信をして処理するメッセージ　受信をしないメッセージ　
          #　を、キーやマウスすべてに設定
          #
          # 非アクティブだけど、アクティブっぽくも扱えるモード
          # def active?　　変数 active __
          # これによりwintaskで最上位じゃなくてもactive化？
          #
          #
          # 非アクティブでメッセージ非受信
          # 非アクティブだけどメッセージ受信
          # それぞれフラグを
          #

          o.var_add :clicked , :num , :msg
          o.msg = []
          o.num = num       #  num じゃなくてwintaskに 配列としての要素を持たせるかも
          
          o.var_add :win
          o.win = Object.new
          o.win.var_add :main ,:bar_title , :max , :min , :close
          o.win.var_add :z

          bar_title_d = Image.new(width-90,30,[200,140,140,140])
          b0          = Image.new(30,30,[200,250,200])
          b1          = Image.new(30,30,[240,200,200])
          b2          = Image.new(30,30,[170,210,220])

          ayu = Struct.new(:sym,:x,:y,:d)
          o.win.main      = ayu.new(:main      , 0 , 0 , d  )
          o.win.bar_title = ayu.new(:bar_title , 0 , 0 , bar_title_d )
          o.win.max       = ayu.new(:max   ,  d.width - b0.width  , 0 , b0 )
          o.win.min       = ayu.new(:min   ,  d.width - b0.width - b1.width , 0 , b1 )
          o.win.close     = ayu.new(:close ,  d.width - b0.width - b1.width - b2.width , 0 , b2 )
        end
        
        ss = Hash.new{|a,b| a[b] = 150 }
        ss[0] = 255
        win_z = wintask.index(o)
        winhs = { :alpha => ss[ win_z ] , :z => -win_z  }
        # win
        o.win.instance_eval  do
          [ self.main , self.bar_title , self.max , self.min , self.close ].each do |m|
            m.instance_eval {|r| Window.drawEx o.x + r.x , o.y + r.y , r.d , \
            winhs 
            }
          end
        end

        Window.drawFont o.x , o.y , "#{wintask.index(o)}" , Yuyuko.font , winhs
        Window.drawFont o.x+20 , o.y , "#{o.sym}" , Yuyuko.font , winhs
#        Window.drawFont(50,  60, "--x #{o.x}--y #{o.y} "   , Yuyuko.font)
#        Window.drawFont(50,  10, "--x #{tmp.x}--y #{tmp.y} "   , Yuyuko.font)
        
        # message prociser
        o.msg.each do | msg |
          case msg
          when "WIN_CHANGE"
            p :change
            # ウィンドウがz変更されたら メッセージの再発行とか
#            os_shell_create o , wintask

          when "K_Z"
             p o.sym
             p :z
          when "WIN_CLOSE"
            p :CLOSE
  #          o.delete
          when "M_RBUTTON_PUSH"
             p o.sym
             p "M_RBUTTON_PUSH"
          when "M_RBUTTON_DOWN"
#            p "M_RBUTTON_DOWN"
          when "M_RBUTTON_UP"
#            p "M_RBUTTON_UP"

          when "M_LBUTTON_PUSH"
            p o.sym
            p "M_LBUTTON_PUSH"
            lumia_block = [ o.x + o.d.width - o.win.close.d.width,
                  o.y , o.win.close.d.width , o.win.close.d.height ]
            if Lumia.blockhit( *lumia_block , Input.mousePosX , Input.mousePosY , 1 , 1 ) 
              click_b o , lumia_block  do
                o.msg << "WIN_CLOSE"
              end
            end
          when "M_LBUTTON_DOWN"
  #          p :M_RBUTTON_DOWN

            if Lumia.blockhit( o.x , o.y , o.win.bar_title.d.width , o.win.bar_title.d.height , 
               Input.mousePosX , Input.mousePosY , 1 , 1 ) and ! o.clicked
               o.clicked = true
               tmp.x = o.x - Input.mousePosX 
               tmp.y = o.y - Input.mousePosY 
            end
  
          when "M_LBUTTON_UP"
              o.clicked = false
          end if wintask.first == o
          
        end
        o.msg.clear  # msg clear  

        if o.clicked
            o.x = Input.mousePosX + tmp.x
            o.y = Input.mousePosY + tmp.y

        end
        
      end # miko
      
    end # d

    def init o
       wintask = []
       os_shell_create o , wintask
       window_create o , wintask ,  { :num => 0 , :x => 100 }
       window_create o , wintask ,  { :num => 1 ,:x => 300 , :y => 200  }
       window_create o , wintask , { :num => 2 , :y => 300 }

#      o.fade_in
      o.miko({ sym: :window_system }) do | o |
#        Window.drawFont(50,  10, "--window_system--"   , Yuyuko.font)
#        Window.drawFont(50,  10, "--window_system--"   , Yuyuko.font)
        
      end # o
    end # init
    
  end # window_system

end # m



__END__

=begin
        wintask.drop(1).map do | e |
          retty_block = [ e.x , e.y , e.d.width , e.d.height ]
          if Input.mousePush?(M_RBUTTON)
            if Lumia.blockhit( *retty_block , *mouse)  
              window_narabikae o , wintask , e
              e.msg << "WIN_CHANGE"
            end
          end
        end
=end
