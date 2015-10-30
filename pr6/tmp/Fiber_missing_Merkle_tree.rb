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

Merkle_tree.new.Main :AnneRose_main do | o |
  o.Code do
    case
#    when o.task.empty? then ARGV.replace [ :title ,1,2,3]
#    when o.task.empty? then o.Flandoll << :title
#    when o.task.empty? then o.Flandoll << :title
when nil

    end
    -> &b do lambda do |f|
        lambda{|x|lambda{|y| f[x[x]] [y]}}[
          lambda{|x|lambda{|y| f[x[x]] [y]}}]
      end[ lambda{|f|lambda{|n| b[n , &f] }}]
    end.yield do | ( o , rb ) , &f |
      # case ARGV.shift
      se = Fiber.new do
        loop do
          p se.hash
          c=Fiber.yield
          p se.hash
          case c

          when nil then true
          when -> rb do p :default_functinon, c ; false end
          when -> rb do
              o.Task :"#{rb}" do |o|
                o.Code do
                  o.Main :"#{rb}_main" do |o|
                    Merkle_default_class.new o , rb , "AnneRose" , se
                    o.Code do
                      f[ [o , rb ] ]
                    end # code
                  end # main
                end # co
              end # tas
            end #lm
          end # case

        end # loop
      end # fb
      if o.TOP_NODE.task.empty?
        se.resume :title
        se.resume :title
      end

    end[ [ o , nil ] ] # recursion
  end # code do
end # main
