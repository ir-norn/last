#coding:utf-8
require "__dev/req"  if $0 ==__FILE__


module Merkle_tree_m
  include Tree_task_search_m
  attr_accessor :sym , :up , :func , :task , :n
# TREE TASK SYSTEM ADD  variables
# この2変数はシーン側で足すべきかもね
  attr_accessor :Flandoll , :Scarlet  # Message_Q / Scene間のデータ移動
  def initialize hs = Hash.new , &block
    @sym      = hs[:sym]
    @up       = hs[:up]
    @func     = block
    @task     = []
# scene
    @Flandoll = []
    @Scarlet  = Hash.new
  end
  #
  def __taskloop
    task.each do | b | b.func = b.func[b].func end
  end
  def Main sym , &block
    Task sym , &block
    nil while not __taskloop.empty?
  end
  def Task sym = :task , &block
    task << self.class.new(up:self , sym: :"#{sym}_#{self.hash}" , &block)
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
      up.task.delete self
      task.clear
    end
  end
end # end-module

class Merkle_tree
  include Merkle_tree_m
  include DEBUG_CODE_m
end
