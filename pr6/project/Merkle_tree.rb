#coding:utf-8
require "__dev/req" if $0 ==__FILE__

class Merkle_tree
  include Merkle_tree_m
  include Merkle_tree_m_ex
  include DEBUG_CODE_m
  attr_accessor :Flandoll , :Scarlet  , :fib
  def initialize **_
    super
    @Flandoll = nil # []
    @Scarlet  = Hash.new
  end
end
class Remilia < Fiber
  def << n ; resume n end
end


Merkle_tree.new.Main :__merkle_tree_main_top_node do |o|
  -> &b do lambda do |f|
      lambda{|x|lambda{|y| f[x[x]] [y]}}[
        lambda{|x|lambda{|y| f[x[x]] [y]}}]
    end[ lambda{|f|lambda{|n| b[n , &f] }}]
  end.yield do | ( o , rb ) , &f |
    o.Code do
      if o.TOP_NODE.task.empty? and o.Flandoll then o.Flandoll.resume :tree_view  end
      o.Flandoll = Remilia.new do
        case p Fiber.yield
        when nil then true
        when -> rb do Merkle_tree.Alice    o , rb , f end
        when -> rb do Merkle_tree.loading  o , rb , f end
        when -> rb do
            o.Task :"__#{rb}_task" do |o|
              o.Code do
                o.Main :"#{rb}" do |o|
                  Merkle_scene.new o , rb
                  f[ [o , rb] ]
                end
              end# co
            end # tas
          end #lm
        end # while not o.Flandoll.empty? # case
      end ; o.Flandoll.resume # fiver
    end # code do
  end[ [ o , nil ] ] # recursion
end # main
