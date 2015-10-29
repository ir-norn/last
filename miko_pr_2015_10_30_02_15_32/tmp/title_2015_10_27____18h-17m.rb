#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-27 | 09:17:05
# - meta script | sc/__scene_create.rb
#
require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------


# ---------------------------------------- AnneRose\title ----------------------------------------
module AnneRose
  class Title
    def initialize _
      @node_self = _
      @font      = Font.new 30
      @node_self.Task :window_update do |o| o.Code do
        Window.sync
        Window.update
        exit if Input.update
      end end
      @node_self.Task :debug_code do |o| o.Code do
        if @node_self.DEBUG_CODE.MAIN_LOOP_FLAG
           @node_self.up.delete       if Input.keyPush? K_F4
           @node_self.TOP_NODE.delete if Input.keyPush? K_F6
           break      if Input.keyPush? K_F8
           exit       if Input.keyPush? K_F9
           @node_self.DEBUG_CODE.SCREENSHOT_CALL if Input.keyPush? K_F12
        end

        @node_self.Flandoll << :MSG_CODE1 if Input.keyPush? K_1
        @node_self.Flandoll << :MSG_CODE2 if Input.keyPush? K_2
        @node_self.up.delete              if Input.keyPush? K_9
        @node_self.Scarlet = { :test_data => "test_data_by:#{@node_self.sym}" }
      end end if @node_self.DEBUG_CODE.SCENE_FLAG
      @node_self.DEBUG_CODE.DESTRUCTER do
        p :DESTRUCTER
      end
      main
      @ev   = event_proc
      @flan = flan_proc
    end # initialize
    def flan_proc
      Fiber.new do loop do
        p @node_self.Flandoll << Fiber.yield
      end end
    end
    def event_proc
      Fiber.new do loop do
          case Fiber.yield
          when :VK_0
            p :vk_0
          when :VK_1
          else
            p :message_err
      end end end
    end
    def main

#      @node_self.extend Create_method_print
#      @node_self.extend Create_method_delete_lazy
#      @node_self.delete_lazy 100
#p @node_self.TOP_NODE.sym
#    p  @node_self.search_up(/AnneRose_main/)
      @node_self.Task :default do |o| o.Code do
        if Input.keyPush? K_4
          @ev.resume :VK_sxx
        end
        if Input.keyPush? K_5
          @ev.resume :VK_0
        end
        if Input.keyPush? K_6
          @flan.resume :menu
        end

        Window.draw_font(50,  10, "--AnneRose/title--" , @font)
        # @node_self.print(50,  90, "--xxxx--")
#        @node_self.print(50,  90, "--xxxx--")
        # @node_self.Window.print(50,  90, "--xxxx--" )
      end end
    end # def
  end # AnneRose\title
end # m
