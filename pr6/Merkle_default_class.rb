#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

# --------------

class Merkle_default_class
  def initialize _ , name , project_name
    @project_name = project_name
    @scene_name = name
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
         exit                       if Input.keyPush? K_F9
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
          yield @node_self
        end end
      end
    end
    case ("./#{@project_name}_src/#{@scene_name}_load.rb")
    when -> rb {  File.exists?(rb) && load(rb) }
    else
      p :_load_rb_error
      @node_self.Task :default do |o| o.Code do
        Window.drawFont(50,  60, "--404 rb file not found--" , @font)
        Window.drawFont(50,  10, "--#{@project_name}/#{@scene_name}--" , @font)
      end end
    end
    # @node_self.Task :default do |o| o.Code do
    #   Window.drawFont(50,  60, "--default_message--" , @font)
    #   Window.drawFont(50,  200, "--#{@project_name}/#{@scene_name}--" , @font)
    # end end

  end # def
end # AnneRose\title
