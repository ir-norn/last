# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__
# require "./Yuyu_yuyuko"
#
#

## ---------------- 最低限のコア部分
module Yuyu_yuyukosama_dd
  def dd_get
    @dd_c    ||= 0
    @dd_p    ||= 0
    @dd_wait ||= 20
    if (@dd_c+=1)% @dd_wait == 0
      @dd_c = 0
      @dd_p = (@dd_p+1) % @dd.size
    end
    @dd[ @dd_p ]
  end
end

module Game_Object_m
  attr_accessor :x , :y , :d , :speed , :angle
end
module Tree_task_m
  include Tree_task_search_m
  include Game_Object_m
  attr_accessor :func ,:task ,:sym ,:n ,:up
  attr_accessor :func_old
  attr_accessor :destruct
  def initialize hs = Hash.new , &block
    @func     = block
    @task     = Hash.new
    @up       = hs[:up]
    @sym      = hs[:sym]
    @n        = hs[:n]
    @destruct = hs[:destruct] || ->{ }
  end
end

module Yuyu_yuyukosama
  include Tree_task_search_m
  # include Yuyu_yuyukosama_dd
  # include Yuyu_yuyukosama_ddd # 未実装
  attr_accessor :Flandoll
  attr_accessor :Scarlet
  attr_accessor :d
# 消したい
  attr_accessor :dd_p
  attr_accessor :dd_wait
  attr_accessor :dd   # 二次元配列　画像
  attr_accessor :ddd  # 三次元配列 画像
#
  attr_accessor :x
  attr_accessor :y
  attr_accessor :speed , :angle
# task kannrenn
  attr_accessor :func
  attr_accessor :func_old # 初期化されてるかどうかのフラグで使った
  attr_accessor :task
  attr_accessor :up
  attr_accessor :sym
# variables
  attr_accessor :n
# 消したい
  attr_accessor :st # OpenStruct
  attr_accessor :str      # initialize で初期化しても大丈夫な
  attr_accessor :sstr     # cpu速度になったら 初期化させる
  attr_accessor :remi
  attr_accessor :lumia
  attr_accessor :lacus
# Destructer
  attr_accessor :destruct  # def Destruct で yield 代入
# task add
  attr_accessor :task_do  # hash error 対策
# eval
  attr_accessor :eval_do
# counter
  attr_accessor :c
  def initialize hs = Hash.new
    @func    = ->o do yield o end if iterator?
    @task    = Hash.new
    @up      = hs[:up]
    @sym     = hs[:sym] || :nil
    @task_do = []
    @st      = OpenStruct.new
#kihon
    @dd     = hs[:dd] || []
    if @dd.first then  @d  = @dd.first
    else               @d  = hs[:d]   end
    @x        = hs[:x]
    @y        = hs[:y]
#task kannei
    @destruct = hs[:destruct] || ->{ }
    @c        = hs[:c]  || 0  # 流石にこれは消す
    @n        = hs[:n]  || 0
# scene
    @Flandoll = []
    @Scarlet  = Hash.new
  end

  # selfをreturnした代入で ifとfunc_old は無くせる可能性
  # -- gist tree_task.rb 参照
  # 1 , (task = code).run ; 2,3,4... , (code = code).run
  def __mainloop_sub ek
    loop do
      nyan = task
      task.each do | key , mm |
        miyu = mm.func.call mm
        if miyu.class == self.class
            nyan[key].func_old = nyan[key].func
            nyan[key].func = miyu.func
        end
      end
      task_do.each do | a , b | task.store( a , b ) end ; task_do.clear

      break unless ek
      # ------ ek==true ループのときだけ下は実行される ---------
      Window.sync
      Window.update
      exit       if Input.update
      if $de_loop_command
        $Scarlet.izayoi = ! $Scarlet.izayoi if Input.keyPush? K_F2 # あたり判定
        #   Window.fps = 0  # F3
        delete     if Input.keyPush? K_F4
        search_up( $Scarlet.TOP_SYM ).delete if Input.keyPush? K_F6
        break      if Input.keyPush? K_F8
        exit       if Input.keyPush? K_F9
        Lumia.screenshot if Input.keyPush? K_F12
      end
      break      if task.empty?
    end
  end
  def Main sym
    Task sym do | o |
      yield o
    end
    __mainloop_sub true
  end # def


  # def A o
  #   o.Task :nyaxxxx do |o|  o.Code do
  #        Window.drawFont(50,  10, "--AAAAA--"   , $Scarlet.Font)
  #      end end end

#`store': can't add a new key into hash during iteration (RuntimeError)  対策
#    task.store( sym , self.class.new(hs.merge( up:self , sym:sym ) , &block))
#
# 問題ありすぎ　 task_do 使うか　通常task.store　か　要検討
#
  def Task sym = :task , hs = Hash.new , &block
    hs.store(:up  , self )
    hs.store(:sym , sym )
    begin #通常
      self.task.store( sym , self.class.new(hs) do | o |
         yield o
      end)
#      p :task_add
    rescue => e
      (print "#{__FILE__} Task_do rescue..." ; p $1) if $__debug__0
      #エラー時はこっちで
    # task_do  で 要素の遅延追加を行う
    self.task_do << [ sym , self.class.new(hs) do | o |
       yield o
    end  ]
    #
    #  during iteration 回避のための 無理やりな代入 使わない予定
#    self.task = self.task.clone.merge( { sym.to_sym => self.class.new(hs) do | o |
#       yield o
#    end })
    end # rescue
  end # def
  def Task_Code sym = :task_code , hs = Hash.new
    Task sym , hs do | o |
      o.Code do
        yield o
      end # code
    end # task
  end # def
  def __main_sub hs , ek
    self.class.new do
      yield
      __mainloop_sub ek
    end # new
  end # def

  def Code_r tf , hs = Hash.new , &block
    __main_sub hs , tf , &block
  end
  def Code hs = Hash.new , &block
    __main_sub hs , false , &block
  end
  # taskloop
  def Loop sym = :loop , hs = Hash.new
    Task( :loop_task ) do |o|
      o.Code_r true do
        o.Task(sym , hs) do |o|
           yield o
        end # task //
      end # code //
    end # task //
  end # def
  alias Task_Loop Loop

#  ----------------------------------------------------
  def uniq_sym str = "_rb_uniq_" , n = rand(1000)
    $st_uniq_sym ||= [*1..500].dmap.to_s
    n = $st_uniq_sym.rotate![-1]
    return str.to_s + "_" + n
  end # def

# ---
  def delete
    o = self
    unless o.task.empty?
      o.task.each do | key , value |
        value.delete if value
      end
    end
    # デストラクタから delete 呼び出した時に 無限ループに突入するので、
    de = o.destruct.clone
    o.destruct = ->{ }
    de.call
    if o.up
      o.up.task.delete o.sym
    end
  end # def
  # counter
  def c ;	@c += 1 end
end # end-class
#
# main object class + 拡張 および実装中のものたち
#-----------------------------------------------------------------
#
# search系のメソッドについて
# 探索結果の中にに同名のシンボルがあると上書きされてしまう
#
class Yuyukosama
#  extend  Scarlet::Default
  include Yuyu_yuyukosama
  # okk
#-------------------------------------deletge 関係 --------------------------------
  # task ga empty ni nattara delete

  # doudaro
#   def delete_fake
#     @x = 5000
#     @y = 5000
# #    up.task[sym].func = ->*h{ }
#   end
  # totyuu jissou

  def delete_lazy wait
    Task uniq_sym "lazy-task" do | o |
      o.Code do
        wait -= 1
        if wait < 0
          delete
        end
      end
    end
  end

  # def top_node
  #  p :top_node_is_bug_method
  #   exit
  #   up.top_node if up
  #   return self
  # end
#
#
# -------------------------------- 探索など ----------------------------------
#   # もしかして使えない
#   def return_sym  sym # topsym
#     o = self
# =begin
#     yu.task.each do|k,v|
#       v.delete
#     end
#     return 0
#   p yu.sym
#
# =end
#     return unless o.up
#     if o.up.sym == sym
#       o.delete
#     else
#       o.up.return_sym sym
#     end
#   end # def
# -------------------------------- symtax shuger ------------------------
  def height ; d.height end
  def width  ; d.width  end
  def Destruct &b
    @destruct = b
  end
  # 選択可にしたい、（あとで
  # def each_ary sym = /(.*)/
  #   if iterator?
  #     self.task.each_value do | m |
  #       yield m
  #     end
  #   else
  #     self.task.each_value
  #   end
  # end # def

  alias YuyuMain Main
end
Tree_Diagram = Yuyukosama

 
