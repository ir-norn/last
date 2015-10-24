# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__
#
# 2015-10-24 17:07:04 +0900
# ---------------------------------------- AnneRose\story_stage3 ----------------------------------------
module AnneRose
  class Story_stage3
    attr_accessor :node_self, :font
    def initialize _
      @node_self = _
      @font      = Font.new 30
      node_self.Task :default_code do |o|  o.Code do
        node_self.Flandoll << :MSG_CODE1 if Input.keyPush? K_1
        node_self.Flandoll << :MSG_CODE2 if Input.keyPush? K_2
        node_self.up.delete              if Input.keyPush? K_9
        node_self.Scarlet = { :test_data => "test_data_by:#{node_self.sym}" }
      end end if $__DEBUG_CODE.SCENE_FLAG
      main
    end # initialize
    def main
      node_self.Task :default do |o|  o.Code do
        Window.drawFont(50,  10, "--AnneRose/story_stage3--"   , @font)
      end end
    end # def
  end # AnneRose\story_stage3
end # m
