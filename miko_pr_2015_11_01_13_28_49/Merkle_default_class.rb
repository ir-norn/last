#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

class Merkle_default_class
  def initialize _ , name
    @node_self    = _
    @scene_name   = name
    @load_src     = "AnneRose"
    @node_self.Task :__window_update do |o| o.Code do
      Window.sync
      Window.update
      exit if Input.update
    end end
    @node_self.Task :__debug_code do |o| o.Code do
      @node_self.up.delete       if Input.keyPush? K_F4
      @node_self.TOP_NODE.delete if Input.keyPush? K_F6
      exit                       if Input.keyPush? K_F9
      @node_self.DEBUG_CODE.SCREENSHOT_CALL if Input.keyPush? K_F12
      @node_self.up.delete                  if Input.keyPush? K_9

      @node_self.Flandoll << :title         if Input.keyPush? K_1
      @node_self.Flandoll << :menu          if Input.keyPush? K_2
      @node_self.Flandoll << :tree_view     if Input.keyPush? K_3
      @node_self.Scarlet = { :test_data => "test_data_by:#{@node_self.sym}" }
    end end if @node_self.DEBUG_CODE.SCENE_FLAG
    @node_self.DEBUG_CODE.DESTRUCTER do end
    main
  end # initialize
  def main
# //////////////////////////////////////////////////////////////////////////////////////
#--------- メソッド内でrefine使えない感じなので普通にオーバーライド ------------
    node_self = @node_self
    Window.class_eval do
      @node_self = node_self
      def self.loop
        @node_self.Task :__default do |o| o.Code do
          yield @node_self
        end end
      end
    end

    # -----------------------------------------------
    # Dir.chdir  # 必要
    # *-----------------------------------------
      case ("./#{@load_src}/#{@scene_name}.rb")
      when -> rb {  File.exists?(rb) && load(rb) }
      else
        p :_load_src_error
        @node_self.Task :__load_src_error do |o| o.Code do
          Window.drawFont(50,  60, "--404 rb file not found--" ,  Font.default)
          Window.drawFont(50,  10, "--#{@load_src}/#{@scene_name}--" , Font.default)
        end end
      end
# --- refine してないので後処理self.lopp戻す ---
Window.class_eval do
  def self.loop ; # Window.create rescue p "Window is created"
    while true ; Window.sync ; Window.update ; yield end end end
# //////////////////////////////////////////////////////////////////////////////////////

  end # def
  def self.loading o , rb
    # rb = :"#{rb}_loading"
    rb = :loading
    o.Task :"__#{rb}_task_loading" do |o|
      o.Code do
        o.Main :"#{rb}_loading" do |o|
          new o , rb
          o.Code do end # code
        end # main
      end # co
    end # tas
# 絶対にfalse
    return false
  end
end # AnneRose\title
