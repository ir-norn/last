#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

module Merkle_tree_m
  attr_accessor :sym , :up , :func , :task
  def initialize sym: nil , up: nil , &block
    @sym      = sym
    @up       = up
    @func     = block
    @task     = []
  end
  def _taskloop
    task.each do | b | b.func = b.func[b].func end
  end
  def Main sym , &block
    Task sym , &block
    nil while not _taskloop.empty?
  end
  def Task sym = :task , &block
    task << self.class.new(sym:sym , up:self , &block)
  end
  def Code
    self.class.new do
      yield
      _taskloop
      self
    end
  end
end

# 別ファイルへ。　task_config?
class Merkle_tree
  include Merkle_tree_m
  include Merkle_tree_m_ex
  include DEBUG_CODE_m
  attr_accessor :Flandoll , :Scarlet
  def initialize **_
    super
    @Flandoll = []
    @Scarlet  = Hash.new
  end
end
