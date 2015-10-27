#coding:utf-8
require "__dev/req"  if $0 ==__FILE__


module Merkle_tree_m
  include Tree_task_search_m
  attr_accessor :sym , :up , :func , :n
  attr_accessor :task , :task_do  # hash error 対策
# TREE TASK SYSTEM ADD  variables
  attr_accessor :Flandoll , :Scarlet  # Message_Q / Scene間のデータ移動
  def initialize hs = Hash.new , &block
    @sym     = hs[:sym] || :nil
    @up      = hs[:up]
    @func    = block
    @task    = Hash.new
    @task_do = []
# scene
    @Flandoll = []
    @Scarlet  = Hash.new
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
    task_do << self.class.new(up:self , sym:"#{sym}_#{self.hash}".to_sym , &block)
  end
  def Code
    self.class.new do
      yield
      __taskloop
      self
    end
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
  end
end # end-module

class Merkle_tree
  include Merkle_tree_m
  include DEBUG_CODE_m
end
