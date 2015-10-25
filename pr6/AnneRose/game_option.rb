#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-25 | 09:11:18
# - meta script is sc/__scene_create.rb
#
# ----------------------------------------------------------------

require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- AnneRose\game_option ----------------------------------------
module AnneRose
  class Game_option
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
        Window.drawFont(50,  10, "--AnneRose/game_option--"   , @font)
      end end
    end # def
  end # AnneRose\game_option
end # m
