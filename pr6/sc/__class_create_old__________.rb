# -*- encoding: UTF-8 -*-
require "kconv"
require "Time"


p "class_create_old_version"

exit

ARGV.each do |m|

str = <<-TTT
#coding:utf-8
# --------------------------------
# this file creating meta
# - #{Time.now}
# - meta script is #{__FILE__}
# --------------------------------

require "__tewi/req"  if $0 ==__FILE__

# ---------------------------------------- #{m} ----------------------------------------
module AnneRose
  class #{File.basename(m).capitalize}
    attr_accessor :node_self, :font
    def initialize _
      @node_self = _
      @font      = Font.new 30
      node_self.Task :default_code do |o|  o.Code do
        node_self.Flandoll << :MSG_CODE1 if Input.keyPush? K_1
        node_self.Flandoll << :MSG_CODE2 if Input.keyPush? K_2
        node_self.up.delete              if Input.keyPush? K_9
        node_self.Scarlet = { :test_data => "test_data_by:\#{node_self.sym}" }
      end end if $__DEBUG_CODE.SCENE_FLAG
      main
    end # initialize
    def main
      node_self.Task :default do |o|  o.Code do
        Window.drawFont(50,  10, "--#{File.dirname(m)}/#{File.basename(m)}--"   , @font)
      end end
    end \# def
  end \# #{m}
end \# m
TTT


  system" md #{File.dirname(m)}"

  file = m + ".rb"
  if File.exists?( file )
    puts "#{file} file _ exists _ error"
  else
    puts str
    open( file , "w").print str.toutf8
    puts "created file _ #{file}"
  end

end
