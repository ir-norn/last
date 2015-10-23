# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__

require "ostruct"
# 
# p A.super_uniq_sym("test",1)
# p A.super_uniq_sym("test",1)
# p A.super_uniq_sym_.hs.delete :test_1
# p A.super_uniq_sym_.hs
# p A.super_uniq_sym("test",1)
# 
# OpenStruct 使用してるほうは、ライブラリないの状態変数を外部に公開可
# lambdaやlambda再帰で作ってるほうは、記述は簡潔だけど状態変数を外部からアクセスする手段なし
#
#
# 2012 8 15
#
# @@ 変数 で extendならスコープ汚さない
# includeはだめぽ
#
#


module Scarlet_module
  class << self
    def init ssss , mod , h
      h.each do | m , *h |
        next unless ssss.methods.include? m
        a = ssss.method( m ).call *h
        mod.define_singleton_method "#{m}".to_sym  do | *h , &block | a.method( m ).call *h , &block  end
        mod.define_singleton_method "#{m.to_s.delete('!?')}_".to_sym do a end
      end
    end
    
    # lambda 
    def init_lambda ssss , mod , h
      h.each do | m , *h |
        next unless ssss.methods.include? m
        a = ssss.method( m ).call *h
        mod.define_singleton_method "#{m}".to_sym  do | *h , &block | a.call *h , &block  end
        mod.define_singleton_method "#{m.to_s.delete('!?')}_".to_sym do a end
      end
    end # init
  end

  module Yield_rec
    def self.extended mod
      Scarlet_module.init self , mod , [
       (self.singleton_methods - [__method__])
      ]
    end
# recursion
    def self.yield_rec *h
      ru       = Hash.new
      ru[:vvv] = nil # lambda do |*h| end
      a = OpenStruct.new ru
      a.define_singleton_method __method__ do | *h , &block |
        a.vvv = lambda do |*h| block.call *h end if block
        a.vvv.call *h
      end
      return a
    end
  end
  extend Yield_rec

# ---------------------------- test ---------------------------
  module Test_Default
    def self.extended mod
      Scarlet_module.init_lambda self , mod , [
        (self.singleton_methods - [__method__]) ,
      ]
    end

    def self.uniq_sym *h
      hs = Hash.new
      lambda do | str = "uniq_" , n = rand(10000) | Scarlet_module.yield_rec str , n do | str , n |
        tmp = "#{str}_#{n}".to_sym
        if hs.keys.include? tmp
          return Scarlet_module.yield_rec str , n + 1
        else
          hs.store( tmp , true )
          return tmp
        end
      end # recursion
      end # lambda
    end # self
  end # Dfault
# ----------------------------------------- //test------------------

  module Default
    def self.extended mod
#      p (self.singleton_methods - [__method__])
      Scarlet_module.init self , mod , [
        [ :yield_recursion ] ,
        [ :super_uniq_sym  ] ,
      ]
    end
    # こっちの消してもいいかも
    # 縺ェ繧薙°yield縺渡せない  iterator? も false になる &block で何とかする
    def self.yield_recursion *h
      ru       = Hash.new
      ru[:vvv] = nil # lambda do |*h| end
      a = OpenStruct.new ru
      a.define_singleton_method __method__ do | *h , &block |
        a.vvv = lambda do |*h| block.call *h end if block
        a.vvv.call *h
      end

      a
    end
    def self.super_uniq_sym *h
      ru = Hash.new
      ru[:hs] = Hash.new
      a = OpenStruct.new ru
      a.define_singleton_method __method__ do | str = "uniq_" , n = rand(10000) |
        lambda do
          tmp = "#{str}_#{n}".to_sym
          if a.hs.keys.include? tmp
            return super_uniq_sym str , n + 1
          else
            a.hs.store( tmp , true )
            return tmp
          end
        end.call # lambda
      end # singleton
      return a
    end # self
  end # Dfault
  module Key
    def self.extended mod
      Scarlet_module.init self , mod , [
        *(self.singleton_methods - [__method__])
#        [ :keyDownWait? ] ,
      ]
    end
    def self.keyDownWait? *h
      ru = Hash.new
      ru[:wait]       = 20
      ru[:loop_wait]  = 3
      ru[:keyhs]      = Hash.new
      a = OpenStruct.new ru
      a.define_singleton_method __method__ do | key , wait |
        loop_wait = wait
        lambda do
          if Input.keyDown? key
                keyhs[ key ] ||= 0
                keyhs[ key ] += 1
          else  keyhs[ key ]  = 0
          end
          return true if keyhs[ key ] == 1
          return wait < keyhs[ key ] && ( keyhs[ key ]%loop_wait == 0)
        end.call # lambda
      end
      return a
    end # kd

    def self.keyDownWait2? *h
      ru = Hash.new
      ru[:wait]       = 20
      ru[:owait]      = 50
      ru[:loop_wait]  = 3
      ru[:keyhs]      = Hash.new
      ru[:keyhs].default = 0
      a = OpenStruct.new ru
      a.define_singleton_method __method__ do | key , wait , owait |
        loop_wait = wait
        lambda do
          owkey = "ow_#{key}"
          if Input.keyDown?(key) 
            if ( keyhs[ owkey ] == 0 ) || ( keyhs[ owkey ] < owait )
              keyhs[ owkey ] += 1
              return Input.keyPush? key
            end
                keyhs[ key ] += 1
          else  keyhs[ key ]  = 0
                keyhs[ owkey ] = 0
          end
#          return true if keyhs[ key ] == 1
          return wait < keyhs[ key ] && ( keyhs[ key ]%loop_wait == 0)
        end.call # lambda
      end
      return a
    end # kd

  end
end

# keyDownWait
# keyDownWait2
#  を　使えるようにさせる
module Input
	extend Scarlet_module::Key
end


