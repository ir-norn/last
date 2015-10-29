#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-30 | 02:12:24
# - meta script | C:/xxx/gh/last/pr6/sc/__tree_create_v4.rb
#
    require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------
    
    
# --- Merkle_tree ---
    
    Merkle_tree.new.Main :AnneRose_main do | o |
      o.Code do
        case
        when o.task.empty? then o.Flandoll << :title
        end
        case o.Flandoll.pop
        when :title , :MSG_CODE1
          o.Task :title do |o|
            o.Code do
              o.Main :title_main do |o|
#        #coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-30 | 02:12:24
# - meta script | sc/__scene_create.rb
#
# require "__dev/req" if $0 ==__FILE__
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
                end
              end
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
            end
          end if @node_self.DEBUG_CODE.SCENE_FLAG
          main
        end # initialize
        def main
        node_self = @node_self
        Window.class_eval do
          @node_self = node_self
          def self.loop &block
          @node_self.Task :default do |o| o.Code do
            yield @node_self
          end
        end
      end
    end
    load("./AnneRose_src/title_load.rb" , true ) rescue $!
    @node_self.Task :default do |o| o.Code do
      Window.drawFont(50,  10, "--AnneRose/title--" , @font)
    end
  end
end # def
end # AnneRose\title
end # m

# o = ARGV.pop
# AnneRose::Title.new


load "./AnneRose/title.rb" , false
AnneRose::Title.new o
o.Code do
case o.Flandoll.pop
when :menu, :MSG_CODE1
o.Task :menu do |o|
  o.Code do
    o.Main :menu_mainloop do |o|
#           #coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-30 | 02:12:24
# - meta script | sc/__scene_create.rb
#
# require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------
      
      
# ---------------------------------------- AnneRose\menu ----------------------------------------
      module AnneRose
      class Menu
      def initialize _
      @node_self = _
      @font      = Font.new 30
      @node_self.Task :window_update do |o| o.Code do
        Window.sync
        Window.update
        exit if Input.update
      end
    end
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
  end
end if @node_self.DEBUG_CODE.SCENE_FLAG
main
end # initialize
def main
node_self = @node_self
Window.class_eval do
@node_self = node_self
def self.loop &block
@node_self.Task :default do |o| o.Code do
  yield @node_self
end
end
end
end
load("./AnneRose_src/menu_load.rb" , true ) rescue $!
@node_self.Task :default do |o| o.Code do
Window.drawFont(50,  10, "--AnneRose/menu--" , @font)
end
end
end # def
end # AnneRose\menu
end # m

# o = ARGV.pop
# AnneRose::Menu.new


load "./AnneRose/menu.rb" , false
AnneRose::Menu.new o
o.Code do end
end
end
end
end
end
end
end
end
end
end
end
