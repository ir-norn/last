#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

# --------------

class Merkle_default_class
  def initialize _ , name
    @node_self    = _
    @scene_name   = name
    @font         = Font.new 30
    @node_self.Task :window_update do |o| o.Code do
      Window.sync
      Window.update
      exit if Input.update
    end end
    @node_self.Task :debug_code do |o| o.Code do
      @node_self.up.delete       if Input.keyPush? K_F4
      @node_self.TOP_NODE.delete if Input.keyPush? K_F6
      exit                       if Input.keyPush? K_F9
      @node_self.DEBUG_CODE.SCREENSHOT_CALL if Input.keyPush? K_F12
      @node_self.up.delete                  if Input.keyPush? K_9

      @node_self.Flandoll << :title         if Input.keyPush? K_1
      @node_self.Flandoll << :menu          if Input.keyPush? K_2

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
    # -----------------------------------------------
    # Dir.chdir  # 必要
    # *-----------------------------------------
    load_src = "AnneRose"
    case ("./#{load_src}/#{@scene_name}.rb")
    when -> rb {  File.exists?(rb) && load(rb) }
    else
      p :_load_rb_error
      @node_self.Task :default do |o| o.Code do
        Window.drawFont(50,  60, "--404 rb file not found--" , @font)
        Window.drawFont(50,  10, "--#{load_src}/#{@scene_name}--" , @font)
      end end
    end
     # Main do |o|
     #   code  do---
     #     se = Fiber  do ...    loop do ...
     #     end end
     #     if not o.task.empty?
     #        load_class.new o , rb , proj , se  end
     # end
    # @node_self.Task :default do |o| o.Code do
    #   Window.drawFont(50,  60, "--default_message--" , @font)
    #   Window.drawFont(50,  200, "--#{@project_name}/#{@scene_name}--" , @font)
    # end end

  end # def
  def self.load_display *h
#    p :now_loading
    return false
  end
end # AnneRose\title
