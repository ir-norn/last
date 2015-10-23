# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__
# require "./Yuyu_yuyuko"
#
#
#
#

#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
#
=begin
class Test_O 
  attr_accessor :x , :y , :d , :sym , :func
  def initialize hs = Hash.new , &block
    @x     = hs[:x]
    @y     = hs[:y] 
    @d     = hs[:d] 
    @sym   = hs[:sym] 
    @func  = -> o do
     $a = block
     block.call o rescue p $!, $a
     end
  end
  def update
    @func.call self
  end
end
$test_o = []

class Ibuki_Suika < Hash
  include Suika
  def q n , b
    # caller使えば完全ユニークだけど、念のためやめとく
#    c = caller.to_s + n.to_s
p 23322
    c = n.to_s
    if self[ c ]
      
      p :err
      p caller
    else
    self[ c ] = b
    eval"self.#{n} = b"
    end
  end
  
end
=end

## ---------------- 最低限のコア部分

module Yuyu_yuyukosama_dd
  def dd_get
    @dd_c    ||= 0
    @dd_p    ||= 0
    @dd_wait ||= 20
    if (@dd_c+=1)% @dd_wait == 0
      @dd_c = 0
      @dd_p = (@dd_p+1) % @dd.size
    end
    @dd[ @dd_p ]
  end
end

module Yuyu_yuyukosama_ddd
    # 未実装
end

module Yuyu_yuyukosama
  include Yuyu_yuyukosama_dd
  include Yuyu_yuyukosama_ddd # 未実装
  attr_accessor :d
  attr_accessor :dd_p
  attr_accessor :dd_wait
  attr_accessor :dd   # 二次元配列　画像
  attr_accessor :ddd  # 三次元配列 画像
  attr_accessor :x
  attr_accessor :y
  attr_accessor :speed , :angle
# task kannrenn
  attr_accessor :func
  attr_accessor :func_old # 初期化されてるかどうかのフラグで使った
  attr_accessor :task
  attr_accessor :type   # 未使用っぽい
  attr_accessor :up  
  attr_accessor :sym 
# OpenStruct
  attr_accessor :st
# variables
  attr_accessor :n
  attr_accessor :str      # initialize で初期化しても大丈夫な
  attr_accessor :sstr     # cpu速度になったら 初期化させる
  attr_accessor :remi
  attr_accessor :lumia
  attr_accessor :lacus
# Destructer
  attr_accessor :destruct  # def Destruct で yield 代入
# task add
  attr_accessor :task_do  # hash error 対策
# eval
  attr_accessor :eval_do
# counter
  attr_accessor :c
# pattern  --- Ibuki_Suika
#  attr_accessor :pt # misiyouj

  def initialize hs = Hash.new
    @func   = ->o do yield o end if iterator?
    @task   = Hash.new
    @st     = OpenStruct.new
    @task_do = []
#kihon
    @dd     = hs[:dd] || []
    if @dd.first
      @d      = @dd.first
    else
      @d      = hs[:d] 
    end
    @x        = hs[:x]
    @y        = hs[:y]
#task kannei
    @up       = hs[:up]
# sym
    @sym      = hs[:sym] || :nil
# counter
    @destruct =  hs[:destruct] || ->{ }
    @c        = hs[:c] || 0 
# pattern 
#    @pt       = hs[:pt] || Ibuki_Suika.new
#__v
    @n        = hs[:n]   || 0
#    @str   ||= hs[:str]   || ""
#    @sstr  ||= hs[:sstr]  || []
#    @remi  ||= hs[:remi]  || nil #nil lambda nisuru?
#    @lumia ||= hs[:lumia] || nil
#    @lacus ||= hs[:lacus] || nil
#    @eval_do ||= hs[:eval_do] || []
  end

  def __mainloop_sub ek
    loop do
      #
      # 極稀に、funcが、nilになるはずはないのに、nilになってる ので
      # Task で　marge!　をする事によって
      #　 nyan[key].func_old = task[key].func
      #  ここのtaskが別のポインタをさす変数に摩り替わってしまってるので
      #  これはあらかじめ　　nyan = task　でポインタを確保して
      #  元のtaskを操作しないといけない
      #  でもtask側改良して　task_doを入れたので 回避は出来たはず
      # 
      # 
      #
#      begin 
      nyan = task
      task.each do | key , mm |
        $aa = [ key , mm ]
        miyu = mm.func.call mm
        if miyu.class == self.class
            nyan[key].func_old = nyan[key].func
            nyan[key].func = miyu.func
        end
      end

      task_do.each do | a , b |
        task.store( a , b )
      end
      task_do.clear
      
#      if $de
#        $test_o.map &:update
#      end
      
#      rescue => e
#        p :__mainloop_sub
#        p e
#      end

      break unless ek
      # ------ ek==true ループのときだけ下の処理は実行される ---------
      Window.sync
      Window.update

      exit       if Input.update
      
      if $de_loop_command
        exit       if Input.keyPush? K_F9
        break      if Input.keyPush? K_F8
        $Scarlet.izayoi = ! $Scarlet.izayoi if Input.keyPush? K_F2
        Lumia.screenshot if Input.keyPush? K_F12
        search_up( Yuyuko.top_sym ).delete if Input.keyPush? K_F6
        delete     if Input.keyPush? K_F4
        
        # ------------
        @@__debug_f3__code ||= 0
        if Input.keyPush?(K_F3) and @@__debug_f3__code == 0
          Window.fps = 0
          @@__debug_f3__code = 1
        elsif Input.keyPush?(K_F3) and @@__debug_f3__code == 1
          Window.fps = 60
          @@__debug_f3__code = 0
        end
        # --------------
      end

      break      if task.empty?
    end
  end
  def Main sym = Yuyuko.top_sym ,  hs = Hash.new
    Task sym , hs do | o |
      Yuyuko.TOP_NODE = o
      yield o
    end
    __mainloop_sub true
  end # def

#`store': can't add a new key into hash during iteration (RuntimeError)  対策
  def Task sym = "task" , hs = Hash.new
    hs.store(:up  , self )
    hs.store(:sym , sym )

    if sym.class == Symbol
#      p Symbol.all_symbols.size
#      p sym
#      exit
    end

    begin
      self.task.store( sym , self.class.new(hs) do | o |
         yield o
      end)
#      p :task_add
    rescue => e
#    p e
    #
    # task_do  で 要素の遅延追加を行う
    #
    self.task_do << [ sym , self.class.new(hs) do | o |
       yield o
    end  ]
    #
    # 無理やりな代入
    # ちょっと色々とrubyのバグか、設計のバグかに触りそうなのでこっちはやめておく
    # 速度も遅いし
    #
#    self.task = self.task.clone.merge( { sym.to_sym => self.class.new(hs) do | o |
#       yield o
#    end })

    end # rescue 
  end # def
  def Task_Code sym = "taskcode" , hs = Hash.new
    Task sym , hs do | o |
      o.Code do
        yield o
      end # code
    end # task
  end # def
  def __main_sub hs , ek
    self.class.new do
      yield
      __mainloop_sub ek
    end # new
  end # def

  def Loop_sub hs = Hash.new , &block
    __main_sub hs , true , &block
  end
  def Code hs = Hash.new , &block
    __main_sub hs , false , &block
  end
  # taskloop
  def Loop sym = "Loop" , hs = Hash.new
    Task( "nyannyan" ) do |o|
      o.Loop_sub do
        o.Task(sym , hs) do |o|
           yield o
        end # task //
      end # code //
    end # task //
  end # def

# ------------------------------- BUG ---------------------------------
#
# uniq_sym
# 
# 現在の階層からかぶらないシンボルを返すのではなく
# 全階層から絶対にかぶらないシンボルを返す形に変える
# そうないとsearch_down_allとかで重複シンボルが上書きされる
# ただそれは速度に難ありなので、連番とかランダムな英数字で生成
#
# ---------------------------------------------------------------------
#
# symbol は200万程度生成するとruby落ちるので　　文字列で生成する事
#
#
#



  def uniq_sym str = "_rb_uniq_" , n = rand(1000)
#    @@__uniq_sym__var   ||= 0
#    @@__uniq_sym__var += 1
#    n = @@__uniq_sym__var

    $st_uniq_sym ||= [*1..500].dmap.to_s
    n = $st_uniq_sym.rotate![-1]
    return str.to_s + "_" + n
    
    return
    tmp = "#{str}_#{n}"
    if self.task.include? tmp
      return uniq_sym str , n + 1
    else
      return tmp
    end
  end # def

# ---
  def delete
    o = self
    unless o.task.empty?
      o.task.each do | key , value |
        value.delete if value
      end
    end
    # デストラクタから delete 呼び出した時に
    # 無限ループに突入するので、
    # 
    de = o.destruct.clone
    o.destruct = ->{ }
    de.call
#    o.destruct.call
    if o.up
      o.up.task.delete o.sym
    end
  end # def

  # counter
  def c
  	@c += 1
  end

end





#
#
#
#
#
#
#
#
#
#
#
#
#
# 拡張 および実装中のものたち
#-----------------------------------------------------------------
#
# search系のメソッドについて
# 探索結果の中にに同名のシンボルがあると上書きされてしまう






class Yuyukosama
#  extend  Scarlet::Default
  include Yuyu_yuyukosama
  # okk
#-------------------------------------deletge 関係 --------------------------------
  # task ga empty ni nattara delete
  def delete_lazy_empty
    if task.empty?
      delete
    end
  end

  # doudaro 
  def delete_fake
    @x = 5000
    @y = 5000
#    up.task[sym].func = ->*h{ }
  end

  
  # totyuu jissou
  def delete_lazy wait
    Task uniq_sym "task" do | o |
      o.Code do
        wait -= 1
        if wait < 0
          delete
        end
      end
    end
  end



  def top_node 
    up.top_node if up
    return self
  end


# 
# 
# -------------------------------- 探索など ----------------------------------
# 



  
  # もしかして使えない
  def return_sym sym = Yuyuko.top_sym
    o = self
=begin
    yu.task.each do|k,v|
      v.delete
    end
    return 0
  p yu.sym

=end
    return unless o.up
    if o.up.sym == sym
      o.delete
    else
      o.up.return_sym sym
    end
  end # def
#
#
# しっっっぬほど遅い！
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






#
#
# -------------------------------- symtax shuger ------------------------
#
#


  def height
    d.height
  end
  def width
    d.width
  end

  def Destruct &b
    @destruct = b
  end


  # 選択可にしたい、（あとで
  def each_ary sym = /(.*)/
    if iterator?
      self.task.each_value do | m |
        yield m
      end
    else
      self.task.each_value
    end
  end # def

  alias YuyuMain Main
end
Tree_Diagram = Yuyukosama

 