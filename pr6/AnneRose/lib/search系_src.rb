
#
# 名前の重なりを考慮出来ていないので、まだ使わない
#
#
=begin
### return Hash
#  self含める
    def search_up_all sym = /(.*)/
      search_up_all_self(sym).merge({ self.sym => self })
    end
  # self 含めず
    def search_up_all_min sym = /(.*)/
      up ? up.search_up_all_min(sym).merge( (up.sym=~sym) ? { up.sym => up } : Hash.new ) : Hash.new
    end

    def search_down_all sym = /(.*)/
       search_down_all_min(sym).merge({ self.sym => self })
    end
    def search_down_all_min sym = /(.*)/
      task.each.inject(Hash.new) do | stack , ( key , value ) |
        stack.merge! value.search_down_all_min sym unless value.task.empty?
        next stack unless key =~ /#{sym}/
        stack.merge({ key => value })
      end
    end

# searh_do_all  test mada desu
#
# 自分と同じ階層のタスク
    def search_do_all sym = /(.*)/
      task.each.inject( Hash.new ) do | stack , ( key , value ) |
        if sym =~ key
          stack[key] = value
        end
        stack
      end
  #    Hash.new
    end
    def search_do sym = /(.*)/
      task.each do | key , value |
        return value if sym =~ /#{key}/
      end
      nil
    end
=end
