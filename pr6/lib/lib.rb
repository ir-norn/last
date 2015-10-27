#coding:utf-8
require "__dev/req"  if $0 ==__FILE__

#
# self.extend module
# -- lib --
module Create_method_print
  def self.extended o
    o.extend Module.new { attr_accessor :print }
    font = Font.new(50)
    o.define_singleton_method :print do |x , y , str|
      Window.drawFont x, y, str, font
    end
  end
end

module Create_method_delete_lazy
  def delete_lazy wait
    Task :lazy_task do | o |
      o.Code do
        delete if (wait-=1) < 0
      end
    end
  end
end

module Create_method_delete_if_empty
  def delete_if_empty
    if task.empty?
      delete
    end
  end
end # end-module-2
