#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

module Merkle_tree_m
  attr_accessor :sym , :up , :func , :task
  def initialize sym: nil , up: nil , &proc
    @sym      = sym
    @up       = up
    @func     = proc
    @task     = []
  end
  def _taskloop
    task.each do | b | b.func = b.func[b].func end
  end
  def Main sym
    Task sym , &proc
    nil while not _taskloop.empty?
  end
  def Task sym = :task
    task << self.class.new(sym:sym , up:self , &proc)
  end
  def Code
    self.class.new do
      yield
      _taskloop
      self
    end
  end
end
