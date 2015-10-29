#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-30 | 02:34:50
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
                Merkle_default_class.new o , "title" , "AnneRose"
                o.Code do
                  case o.Flandoll.pop
                  when :menu , :MSG_CODE1
                    o.Task :menu do |o|
                      o.Code do
                        o.Main :menu_main do |o|
                          Merkle_default_class.new o , "menu" , "AnneRose"
##        #{open("./AnneRose/menu.rb").read}
#        load "./AnneRose/menu.rb" , false
#       AnneRose::Menu.new o

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
