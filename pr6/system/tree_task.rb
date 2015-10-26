#coding:utf-8

require "__dev/req"  if $0 ==__FILE__

# -- lib --
module Create_method_uniq_sym
  class << self
    def extended o
      o.var_add :uniq_sym
      o.uniq_sym     = c_uniq_sym
    end
    def c_uniq_sym
      _=0;->sym=""{ return "#{sym}_uniq_#{_+=1}".to_sym }
    end
  end
end

module Game_Object_m
  attr_accessor :x , :y , :d , :speed , :angle
end

module DEBUG_CODE_CLASS_m
  class DEBUG_CODE_CLASS
    attr_accessor :MAIN_LOOP , :STATIC_LOGIC , :ERROR_MESSAGE , :SCENE_FLAG
    def initialize
      @MAIN_LOOP        = true
      @ERROR_MESSAGE    = true
      @SCENE_FLAG       = true
      @STATIC_LOGIC_var = ->{_={};->{ _[caller.to_s] ? false : _[caller.to_s] = true }}.call
    end
    def STATIC_LOGIC
     @STATIC_LOGIC_var.call
    end
  end
end

module Merkle_tree_m
  include Tree_task_search_m
  include DEBUG_CODE_CLASS_m
  attr_accessor :DEBUG_CODE
# task
  attr_accessor :func
  attr_accessor :task ,:up ,:sym , :n
  attr_accessor :task_do  # hash error 対策
# TREE TASK SYSTEM ADD  variables
  attr_accessor :Flandoll
  attr_accessor :Scarlet
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
    @DEBUG_CODE = DEBUG_CODE_CLASS.new
# method add
    extend Create_method_uniq_sym
  end
  #
  def __taskloop
    task_do.each do | b | task.store( b.sym , b ) end ; task_do.clear
    task.map do | key , v | task[key].func = v.func[v].func end
  end
  def Main sym , &block
    Task sym , &block
    nil while not __taskloop.empty?
  end
  def Task sym = :task , hs = Hash.new , &block
    self.task_do << self.class.new(hs.merge( up:self , sym:self.uniq_sym[sym] ) , &block)
  end
  def Code
    self.class.new do
      yield
      __taskloop
      self
    end # new
  end

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
class Merkle_tree
#  extend  Scarlet::Default
  include Merkle_tree_m
  # okk
#-------------------------------------deletge 関係 --------------------------------
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
  rescue
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
