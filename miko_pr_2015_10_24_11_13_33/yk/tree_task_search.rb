

module Tree_task_search_m

  #
  #
  # -------------------------------- 探索など ----------------------------------
  #
  #
    def search_down sym = /(.*)/ , o = self
      o.task.each.inject(Hash.new) do | stack , ( key , value ) |
        stack.merge! value.search_down_all_test sym unless value.task.empty?
        return value unless key =~ /#{sym}/
        stack.merge({ key => value })
      end
    end

  #   :window_691 =~ /(window_\d*)/
    def search_up sym , yu = self
      if sym.class == Regexp
  #    p yu.sym
  #    p sym
  #    p yu.sym =~ sym
  #         return yu if $&.to_sym == yu.sym if yu.sym =~ sym # nandakkekore....
           return yu if yu.sym =~ /#{sym}/
      else return yu if yu.sym == sym
      end
      return yu.up.search_up sym if yu.up
      return false
    end

    def search_up_all sym = /(.*)/ , o = self
      o.search_up_all_test(sym).merge({ o.sym => o })
    end

  # self 含めず
    def search_up_all_test sym = /(.*)/ , o = self
      o.up ? o.up.search_up_all_test(sym).merge( (o.up.sym=~sym) ? { o.up.sym => o.up } : Hash.new ) : Hash.new
    end

  # self含める
    def search_down_all sym = /(.*)/ , o = self
       o.search_down_all_test(sym).merge({ o.sym => o })
    end


    def search_down_all_test sym = /(.*)/ , o = self
      o.task.each.inject(Hash.new) do | stack , ( key , value ) |
        stack.merge! value.search_down_all_test sym unless value.task.empty?
        next stack unless key =~ /#{sym}/
        stack.merge({ key => value })
      end
    end

    def search_do_up sym , o = self
      o.up.task.each do | key , value |
        return value if sym =~ key
      end
      nil
    end
    # searh_do_all  test mada desu
    def search_do_all sym = /(.*)/ , o = self
      o.task.each.inject( Hash.new ) do | stack , ( key , value ) |
        if sym =~ key
          stack[key] = value
        end
        stack
      end
  #    Hash.new
    end
    def search_do sym , o = self
      o.task.each do | key , value |
        return value if sym =~ /#{key}/
      end
      nil
    end
end
