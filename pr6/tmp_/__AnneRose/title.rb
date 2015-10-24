# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__
#
# 2015-10-24 11:01:08 +0900
# ---------------------------------------- AnneRose\title ----------------------------------------
module AnneRose
  class Title
    attr_accessor :node_self, :font
    def initialize _
      @node_self = _
      @font      = Font.new 30
      node_self.Task :default_code do |o|  o.Code do
        node_self.Flandoll << :MSG_CODE1 if Input.keyPush? K_1
        node_self.Flandoll << :MSG_CODE2 if Input.keyPush? K_2
        node_self.Flandoll << :return    if Input.keyPush? K_8
        node_self.up.delete              if Input.keyPush? K_9

        node_self.Scarlet = {
          :return => :default ,
          :test_data => "test_data_by:#{node_self.sym}" }
      end end
      main
    end # initialize
    def main
#      p node_self.TOP_NODE.sym
#      p node_self.TOP_SYM
      node_self.Task :default do |o|  o.Code do
        Window.drawFont(50,  10, "--AnneRose/title--"   , @font)
      end end
    end # def
  end # AnneRose\title
end # m
