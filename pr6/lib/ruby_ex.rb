# -*- encoding: UTF-8 -*-

require "__tewi/req"  if $0 ==__FILE__



class Object
  def var_add *h
    if self.class == nil.class or
      self.class == true.class or
      self.class == false.class
      p "nil_class_is_err___var_add___"
    #  self.relace Object.new
    end
    extend Module.new { attr_accessor *h }
  end
end

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
