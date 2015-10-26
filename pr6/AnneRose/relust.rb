#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-26 | 18:40:39
# - meta script | sc/__scene_create.rb
#
require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------


# ---------------------------------------- AnneRose\relust ----------------------------------------
module AnneRose
  class Relust
    def initialize _
      @node_self = _
      @font      = Font.new 30
      @node_self.Task :debug_code do |o|  o.Code do
        @node_self.Flandoll << :MSG_CODE1 if Input.keyPush? K_1
        @node_self.Flandoll << :MSG_CODE2 if Input.keyPush? K_2
        @node_self.up.delete              if Input.keyPush? K_9
        @node_self.Scarlet = { :test_data => "test_data_by:#{@node_self.sym}" }
      end end if @node_self.DEBUG_CODE.SCENE_FLAG
      main
    end # initialize
    def main
      @node_self.Task :default do |o| o.Code do
        Window.drawFont(50,  10, "--AnneRose/relust--" , @font)
      end end
    end # def
  end # AnneRose\relust
end # m
