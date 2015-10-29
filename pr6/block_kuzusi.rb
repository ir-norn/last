require 'dxruby'


if $0 == __FILE__
else
#  p o
end

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
      main
    end # initialize
    def main
        node_self = @node_self
        Window.class_eval do
          @node_self = node_self
          def self.loop &block
            @node_self.Task :default do |o| o.Code do
              yield o
            end end
          end
        end

#        eval open("./block_Merkle_load.rb").read
        load("./block_Merkle_load.rb")

        # @node_self.Task :default do |o| o.Code do
        #   Window.draw_font(50,  10, "--AnneRose/title__block--" , @font)
        # end end

        # @node_self.print(50,  90, "--xxxx--")
#        @node_self.print(50,  90, "--xxxx--")
        # @node_self.Window.print(50,  90, "--xxxx--" )
    end # def
  end # AnneRose\title
end # m
