#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-26 | 23:27:49
# - meta script | C:/xxx/gh/last/pr6/sc/__tree_create_v3.rb
#
  require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------

# --- scene ---
  Dir["./AnneRose/*.rb"].map { |m| require m }

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
              AnneRose::Title.new o
              o.Code do
                case o.Flandoll.pop
                when :menu , :MSG_CODE1
                  o.Task :menu do |o|
                    o.Code do
                      o.Main :menu_main do |o|
                        AnneRose::Menu.new o
                        o.Code do
                          case o.Flandoll.pop
                          when :story, :MSG_CODE1
                            o.Task :story do |o|
                              o.Code do
                                o.Main :story_main do |o|
                                  AnneRose::Story.new o
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
          end
        end
      end
    end
  end
