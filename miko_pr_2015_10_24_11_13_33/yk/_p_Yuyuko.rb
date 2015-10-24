# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__
# require "./Yuyu_yuyuko"
#

module Game_Object_m
  attr_accessor :d
  attr_accessor :x
  attr_accessor :y
  attr_accessor :speed , :angle
end
module Tree_task_m
  include Tree_task_search_m
  include Game_Object_m
  attr_accessor :func ,:task ,:sym ,:n ,:up
  attr_accessor :func_old
  attr_accessor :destruct
  def initialize hs = Hash.new , &block
    @func     = block
    @task     = Hash.new
    @up       = hs[:up]
    @sym      = hs[:sym]
    @n        = hs[:n]
    @destruct = hs[:destruct] || ->{ }
  end
  def __mainloop_sub ek
    loop do
      nyan = task
      task.each do | key , mm |
        miyu = mm.func.call mm
        if miyu.class == self.class
            nyan[key].func_old = nyan[key].func
            nyan[key].func = miyu.func
        end
      end
#      task.each do | key , v | task[key].f = v.f[v].f end

      break unless ek
      # -------- object  ---------
      Window.sync
      Window.update

      exit       if Input.update
      if $__debug__0
        # $Scarlet.izayoi = ! $Scarlet.izayoi if Input.keyPush? K_F2 # toggle
        # $Scarlet.izayoi2 = ! $Scarlet.izayoi2 if Input.keyPush? K_F3 # toggle
        # if $Scarlet.izayoi2 then Window.fps = 0
        #                     else Window.fps = 60 end
        delete     if Input.keyPush? K_F4
        search_up( Yuyuko.top_sym ).delete if Input.keyPush? K_F6
        break      if Input.keyPush? K_F8
        exit       if Input.keyPush? K_F9
        Youmu.screenshot if Input.keyPush? K_F12
      end

      break  if task.empty?
    end
    self
  end
  #  def Main sym = Yuyuko.top_sym ,  hs = Hash.new
    def Main sym = :top_sym_main ,  hs = Hash.new
    Task sym , hs do | o |
#      Yuyuko.TOP_NODE = o
      yield o
    end
    __mainloop_sub true
  end # def

#`store': can't add a new key into hash during iteration (RuntimeError)  対策
  def Task sym = :uniq_sym , hs = Hash.new , &block
    task.store( sym , self.class.new(hs.merge( up:self , sym:sym ) , &block))
  end # def
  def Task_Code sym = :task_code_uniq , hs = Hash.new
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
  def Loop sym = :loop , hs = Hash.new
    Task :task_loop do |o|
      o.Loop_sub do
        o.Task(sym , hs) do |o| yield o end
      end
    end
  end
end # end module

class Tree_task
  include Tree_task_m
#-------------------------------------deletge 関係 --------------------------------
  # task ga empty ni nattara delete
  def delete_lazy_empty
    if task.empty?
      delete
    end
  end

  def delete2
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
    if o.up
      o.up.task.delete o.sym
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

# -------------------------------- symtax shuger ------------------------
def top_node
#  up.top_node if up
  return self
end
#
#
  # def height
  #   d.height
  # end
  # def width
  #   d.width
  # end

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



# --------------------- warn
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

end # class

Yuyukosama = Tree_Diagram  = Tree_task
