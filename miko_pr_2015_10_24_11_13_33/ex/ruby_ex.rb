# -*- encoding: UTF-8 -*-

require "__tewi/req"  if $0 ==__FILE__


# ruby 拡張



# a = {:sym=>:user_shot, :d=>nil, :x=>225.0, :y=>410.0, :speed=>nil, :angle=>nil , nil => 222 }

class Hash
  def value_compact!
    replace value_compact
  end
  def value_compact
    Hash[ each.reject { | _ , v | v.nil? } ]
  end

  def key_compact!
    replace key_compact
  end
  def key_compact
    Hash[ each.reject { | k , _ | k.nil? } ]
  end
end

=begin
p a.value_compact
p a
p a.value_compact!
p a

p a.key_compact!
p a
=end


#
# バグの元になるので　デバッグ専用
#
def static_logic
  @@__static_logic__var ||= Hash.new
  au = @@__static_logic__var
  if au[ caller.to_s ]
    return false
  else
    au[ caller.to_s ] = true
    return true
  end
  
end

# 4.times do
#   p 1
#   p 2 if static_logic
# end




class Binding
  def debug *var
    p caller(1).first
    sz = var.map(&:size).max + 5
    var.map(&:to_s).each do | m |
      p m.ljust( sz ) + eval(m).to_s
    end
  end # df
  
end

=begin
def __debug__marisa
  mystia  = 100
  lorelei = 40
  binding.debug *local_variables
end
# __debug__marisa

=end




class DelegateMap < BasicObject
  def initialize enum 
    @enum = enum
  end
  def method_missing f , *h , &block
    @enum.map do | e | e.__send__( f , *h , &block ) end
  end
end

module Enumerable
  def dmap &b
    return map &b if iterator?
    DelegateMap.new self
  end
end


# p [[1], [2], [3]].dmap.push(6)


module Enumerable
  def map4(op=nil, *args, &blk)
    op ? map { |e| op.intern.to_proc[e, *args]} : map(&blk)
  end
end

# p [[3],[4],[5],].mapp(:push,6,7)


module Enumerable 
  #
  # 引数は未対応
  # ["aaa"  , "bbb" ].hmap(:capitalize , :succ , :chars , :to_a ) do |m|
  #
=begin
  def hmap_old *h , &block
    ret = h.inject self do | a , m |
      a.dmap.method(m).dmap.call
    end
    if iterator?
      ret.map &block 
    else
      ret
    end
  end
=end
  #
  # 引数に対応
  #  ["aaa"  , "bbb" ].hmap(:+ , ["vv"] , :upcase  ,  ) do |m|
  #    p m
  #  end
  #
# p [ [ 1] ].dmap.method(:push).dmap[6]
  def hmap *h , &block
    rr = h.map do | m |
      m if m.class == Array
    end
    rr.rotate!
#    p rr
    ret = h.zip(rr).inject self do | a , ( m , n ) |
      next a if m.class == Array
      a.dmap.method(m).dmap.call( *n )
    end
    if iterator?
      ret.map &block 
    else
      ret
    end

  end # d
end

# ["abc"  , "dfg" ].hmap( :<< , ["zz"] , :split , [//] , :push , [1,2,3] ) do | m |
#  p m
# end




module Lib_ruby_ex
  alias_method :orig_exit, :exit
  def exit *code
    puts "Exiting with code #{code}"  if code.empty?.!
    orig_exit
  end
end

include Lib_ruby_ex

#exit 1 , 2 , Object.allocate





class Object
  def blank?
#    return true if self.nil? or self==false or empty?
    return true unless self
    return true if empty?
    rescue
    return false
  end
end




module Enumerable
  alias nue map
end
class Hash
  def nue
    values.map
  end
end

class Array
  def not_empty?
    not empty?
  end
end



def loop2 n = nil
  if iterator?
    [n].cycle do
      yield n 
    end 
  else
    [n].cycle
  end
end

#
# loop2(2).with_index 5 do | a , b |
#  p a #  => 2
#  p b #  => 5
# end 


class Object
  def var_add *h
    if self.class == nil.class or
      self.class == true.class or
      self.class == false.class 
      p "nil_class_is_err___var_add___"
    #  self.relace Object.new
    end
    extend Module.new { attr_accessor *h }

#    h.each do |m|
#      self.method( m.to_s+"=" ).call Object.new
#    end

  end
end

class Object
=begin
  def var_add2 *h
    h.map(&:to_sym).each do | m |
      m = m.to_s.delete"="
#      self.class.class_eval"
      self.instance_eval"
        def #{m}
          @#{m}
        end
        def #{m}=x
          @#{m} = x
        end"
    end
  end
=end
  def var_add_ex *h
    h.map(&:to_s).each do | m |
      m = m.delete"="
      self.class.class_eval"
        def #{m}
          @#{m}
        end
        def #{m}=x
          @#{m} = x
        end"
    end
  end
end


# 末尾再帰最適化の


class Module
  def recursion_tco func
    func_p = "_tco_#{func}" 
    alias_method func_p , func
    
    nanoha = "nanoha_kannbai"
    arg  = nil
    ff   = true
    define_method func do | *h |
      [ff=nil].cycle do |re|
        return re if ff = (re = method(func_p)[*h]) != nanoha
        h = arg
      end if ff
      arg = h
      nanoha
    end
  end # def
end

=begin

class A
  def f n , a = 1
    if  n  ==  0
       a
    else
       f(n  -  1 , a * n) 
    end
  end
  recursion_tco :f
end

p A.new.f 20000

=end
 



class Regexp
  def +(r)
    Regexp.new(source + r.source)
  end
end




module Suika
  def method_missing( name , *arg )
    if arg.size == 0
      str =  <<TEXT
      def #{name}
        @#{name}
      end
      @#{name}
TEXT
    elsif name.to_s.include? "="
      str =  <<TEXT
      def #{name} miyu
        @#{name} miyu
      end
      self.#{name} arg[0]
TEXT
    else
      p __method__ , str , name , arg , caller
      exit
    end
#    puts str
    instance_eval str
  end
end

module OpenStruct_m
  include Suika
end
