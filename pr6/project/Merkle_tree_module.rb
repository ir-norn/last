#coding:utf-8
require "__dev/req"  if $0 ==__FILE__




class Merkle_tree
  def self.Alice o , rb , f
    case rb
    when /object_/
      o.Task :"__#{rb}_task" do |o|
        Merkle_object.new o , rb
        f[ [o , rb] ]
      end
      return true
    end
    false
  end
  def self.loading o , rb , f
    o.Task :"__#{rb}_task_loading" do |o| o.Code do
        o.Main :"#{rb}_loading" do |o|
          rb = :loading
          Merkle_scene.new o , rb
          f[ [o , rb] ]
        end # main
    end end # task code
    false
  end
end # end-module

module Merkle_node_m
  def initialize _ , rb
    @node_self    = _
    @load_src     = "./AnneRose/" + rb.to_s
    main
  end
  # ////////////////////////////////////////////
  # @node_self 特異クラスのメンバ変数を　yield に渡すと バグる。
  # o.up または ローカル変数に一時格納してから yield に渡す事
  #
  def __Window_refine_do
    node_self = @node_self
    Window.class_eval do
      @node_self = node_self
      def self.loop
        @node_self.Task :__default do |o| o.Code do
          # yield  o , @node_self
          yield o , o.up
        end end
    end end
  end
  def __Window_refine_end
    Window.class_eval do
      def self.loop ; # Window.create rescue p "Window is created"
        while true ; Window.sync ; Window.update ; exit if Input.update ; yield end end end
  end
  def main
    #--------- メソッド内でrefine使えない感じなので普通にオーバーライド ------------
    __Window_refine_do
      case ("#{@load_src}.rb")
      when -> rb {  File.exists?(rb) && load(rb , true) }
#      when -> rb {  File.exists?(rb) && eval(open(rb).read) }
      else
        @node_self.Task :__load_src_error do |o| o.Code do
          Window.drawFont(50,  60, "--404 rb file not found--" ,  Font.default)
          Window.drawFont(50,  10, "--#{@load_src}--" , Font.default)
        end end
      end
    __Window_refine_end
  end # def
end # end-module

class Merkle_scene
  include Merkle_node_m
  def initialize _ , rb
    super
    __scene_code
  end
  def __scene_code
    @node_self.Task :__window_update do |o| o.Code do
      Window.sync
      Window.update
      exit if Input.update
    end end
    @node_self.Task :__debug_code do |o| o.Code do
      if Input.keyPush? K_F1
#        o.TOP_NODE.task.empty? o.Flandoll << :tree_view
      end

      @node_self.up.delete            if Input.keyPush?(K_F4) and not @node_self.up.up == @node_self.TOP_NODE
#      @node_self.up.delete            if Input.keyPush? K_F4
      @node_self.TOP_NODE.up.delete   if Input.keyPush? K_F6
      exit                            if Input.keyPush? K_F9
      @node_self.DEBUG_CODE.SCREENSHOT_CALL if Input.keyPush? K_F12
      @node_self.delete                     if Input.keyPush? K_9

      @node_self.Flandoll << :title         if Input.keyPush? K_1
      @node_self.Flandoll << :menu          if Input.keyPush? K_2
      @node_self.Flandoll << :tree_view     if Input.keyPush? K_3
      @node_self.Flandoll << :object_user0  if Input.keyPush? K_4
      ARGV.replace [ *ARGV , [ 100 , 200 ] ]   if Input.keyPush? K_4

      @node_self.Scarlet = { :test_data => "test_data_by:#{@node_self.sym}" }
    end end if @node_self.DEBUG_CODE.SCENE_FLAG
    @node_self.DEBUG_CODE.DESTRUCTER do end
  end
end # AnneRose\title

class Merkle_object
  include Merkle_node_m
  def initialize _ , name
    super
  end
end
