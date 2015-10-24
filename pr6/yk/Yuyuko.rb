# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__
# require "./Yuyu_yuyuko"
#
#
module Game_Object_m
  attr_accessor :x , :y , :d , :speed , :angle
end

module Yuyu_yuyukosama
  include Tree_task_search_m
# task kannrenn
  attr_accessor :func ,:func_old # 初期化されてるかどうかのフラグで使った
  attr_accessor :task ,:up ,:sym , :n
  attr_accessor :task_do  # hash error 対策
# TREE TASK SYSTEM ADD  variables
  attr_accessor :Flandoll
  attr_accessor :Scarlet
# 定義 def DESTRUCTER
# 使用 DESTRUCTER do ... end
  attr_accessor :DESTRUCTER_FUNC  # 絶対にデバッグ用
  def initialize hs = Hash.new , &block
    @func    = block
    @task    = Hash.new
    @up      = hs[:up]
    @sym     = hs[:sym] || :nil
    @task_do = []
# scene
    @Flandoll = []
    @Scarlet  = Hash.new
# debug
    @DESTRUCTER_FUNC = ->{ }
  end
  # 2015 10 24 最適化code -- gist tree_task.rb 参照  # 1 , (task = code).run ; 2,3,4... , (code = code).run
  def __mainloop tf
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

      break unless tf
      # ------ ek==true ループのときだけ下は実行される ---------
      Window.sync
      Window.update
      exit       if Input.update
      if $__DEBUG_CODE.MAIN_LOOP
        #  あたり判定　表示　非常時
        #  Window.fps = 0  # F3
        delete     if Input.keyPush? K_F4
        search_up( self.TOP_SYM ).delete if Input.keyPush? K_F6
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
    __mainloop true
  end # def
#`store': can't add a new key into hash during iteration (RuntimeError)  対策
#    task.store( sym , self.class.new(hs.merge( up:self , sym:sym ) , &block))
#
# 問題ありすぎ　 task_do 使うか　通常task.store　か　要検討
#
  def Task sym = :task , hs = Hash.new , &block
    self.extend Create_method_uniq_sym
    sym = "#{sym}_#{self.uniq_sym.call}"
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
  def __mainloop_sub  ek
    self.class.new do
      yield
      __mainloop ek
    end # new
  end # def

  def Code tf = false , &block
    __mainloop_sub tf , &block
  end
  # taskloop
  def Loop sym = :loop_task_task , hs = Hash.new
    Task :loop_task  do |o|
      o.Code true do
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
# 上位タスクがdeleteされたら、子タスクまで全部走査して
# デストラクタの実行
# これでもまだ不安だから、デバッグ用とする
#
  def delete
    unless task.empty?
      task.each do | key , value |
        value.delete if value
      end
    end
    # デストラクタから delete 呼び出した時に 無限ループに突入するので、
    de = self.DESTRUCTER_FUNC.clone
    self.DESTRUCTER_FUNC = ->{ }
    de.call
    if up
      up.task.delete self.sym
    end
  end # def
  def DESTRUCTER &b
    self.DESTRUCTER_FUNC = b
  end
  # counter
end # end-class
#
# main object class
class Tree_task
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
# 遅延削除
  def delete_lazy_empty
    if task.empty?
      delete
    end
  end
  def delete_lazy wait
    Task :lazy_task do | o |
      o.Code do
        wait -= 1
        if wait < 0
          delete
        end
      end
    end
  end
# top は :nil
# mainのtopはその1個下なので up.upで再帰してself 2個下のself return
  def TOP_NODE
    return up.up.TOP_NODE if up.up
    self
  end
  def TOP_SYM
    self.TOP_NODE.sym
  end
# -------------------------------- symtax shuger ------------------------
#  def height ; d.height end
#  def width  ; d.width  end
end


 
