#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

# -- lib --
module Create_method_uniq_sym
  class << self
    def extended o
      o.extend Module.new { attr_accessor :uniq_sym }
      o.uniq_sym     = c_uniq_sym
    end
    def c_uniq_sym
      _=0;->sym=""{ return "#{sym}_uniq_#{_+=1}".to_sym }
    end
  end
end

module Merkle_tree_m
  include Tree_task_search_m
# task
  attr_accessor :func
  attr_accessor :task ,:up ,:sym , :n
  attr_accessor :task_do  # hash error 対策
# TREE TASK SYSTEM ADD  variables
  attr_accessor :Flandoll
  attr_accessor :Scarlet
  def initialize hs = Hash.new , &block
    @func    = block
    @task    = Hash.new
    @up      = hs[:up]
    @sym     = hs[:sym] || :nil
    @task_do = []
# scene
    @Flandoll = []
    @Scarlet  = Hash.new
# method add
    extend Create_method_uniq_sym
  end
  #
  def __taskloop
    task_do.each do | b | task.store( b.sym , b ) end.clear
    task.map do | key , v | task[key].func = v.func[v].func end
  end
  def Main sym , &block
    Task sym , &block
    nil while not __taskloop.empty?
  end
  def Task sym = :task , &block
    task_do << self.class.new(up:self , sym:self.uniq_sym[sym] , &block)
  end
  def Code
    self.class.new do
      yield
      __taskloop
      self
    end # new # class.new なくても動くけどなぜか思い。
  end
# --- ユーティリティ ---
  def TOP_NODE
    return up.up.TOP_NODE if up.up
    self
  rescue
    self
  end
  def TOP_SYM
    self.TOP_NODE.sym
  end
  def delete
    if up
      up.task.delete self.sym
      task.clear
    end
  end # def
end # end-module

class Merkle_tree
  include Merkle_tree_m
  include DEBUG_CODE_m
end
