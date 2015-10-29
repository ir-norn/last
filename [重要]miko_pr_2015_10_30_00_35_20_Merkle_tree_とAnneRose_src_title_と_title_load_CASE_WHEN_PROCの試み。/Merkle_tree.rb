#coding:utf-8
#
# ----------------------------------------------------------------
#
# - 2015-10-30 | 00:13:19
# - meta script | C:/xxx/gh/last/pr6/sc/__tree_create_v4.rb
#
    require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------

# --- scene ---
    Dir["./AnneRose/*.rb"].map { |m| require m }

# --- Merkle_tree ---

    Merkle_tree.new.Main :AnneRose_main do | o |
      o.Code do
        case
        when o.task.empty? then ARGV.replace [ :title ,1,2,3]
        end
        case ARGV.first
        when -> rb do false end
        when -> rb do
          next if rb.nil?
          p :ttt
          load("./AnneRose_src/title.rb")
          AnneRose::Title.new o do
            o.Code do
              case ARGV.shift
              when -> rb do
                p 5
              next if rb.nil?
              load("./AnneRose_src/menu.rb")
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
