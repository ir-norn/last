#coding:utf-8
#
# ----------------------------------------------------------------
#
#
require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------
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

Merkle_tree.new.Main :__merkle_tree_main_top_node do | o |
  o.Code do
    if o.task.empty? then o.Flandoll << :tree_view
    end
    -> &b do lambda do |f|
        lambda{|x|lambda{|y| f[x[x]] [y]}}[
          lambda{|x|lambda{|y| f[x[x]] [y]}}]
      end[ lambda{|f|lambda{|n| b[n , &f] }}]
    end.yield do | ( o , rb ) , &f |
      case o.Flandoll.pop
      when nil then true
      when -> rb do Merkle_default_class.loading o , rb end
      when -> rb do
          o.Task :"__#{rb}_task" do |o|
            o.Code do
              o.Main :"#{rb}" do |o|
                Merkle_default_class.new o , rb
                o.Code do
                  f[ [o , rb] ]
                end # code
              end # main
            end # co
          end # tas
        end #lm
      end # case
    end[ [ o , nil ] ] # recursion
  end # code do
end # main
