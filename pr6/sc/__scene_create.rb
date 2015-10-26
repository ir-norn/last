# -*- encoding: UTF-8 -*-
require "kconv"
require "Time"


# ----- TODO
# なし　　not
# ---------------------------
#
# このスクリプト単体では実行しない
# _tree_create.rb内で system から呼び出すこと
# system "ruby sc\\__scene_create.rb  replace #{Project_name}\\#{file} "
# --------------- 簡易保護機能 -----------------------

if ARGV[0] != "replace"
  p " --- error 01 --- "
  p ARGV
  p "ARGV[1] = replace"
  p "ARGV[2] = filename"
  p "_tree_create.rb///system method call please/// replace #{__FILE__}"
  exit
end
if ARGV.size != 2
  p " --- error 02 --- "
  p ARGV
  p "ARGV[1] = replace"
  p "ARGV[2] = filename"
  exit
end
# --------------------------------------------------------

1.times do
  m = ARGV[1]

str = <<-TTTEXT
#coding:utf-8
#
# ----------------------------------------------------------------
#
# - #{Time.now.strftime("%F | %X")}
# - meta script | #{__FILE__}
#
require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------


# ---------------------------------------- #{m} ----------------------------------------
module #{File.dirname(m)}
  class #{File.basename(m).capitalize}
    def initialize _
      @node_self = _
      @font      = Font.new 30
      @node_self.Task :debug_code do |o|  o.Code do
        @node_self.Flandoll << :MSG_CODE1 if Input.keyPush? K_1
        @node_self.Flandoll << :MSG_CODE2 if Input.keyPush? K_2
        @node_self.up.delete              if Input.keyPush? K_9
        @node_self.Scarlet = { :test_data => "test_data_by:\#{@node_self.sym}" }
      end end if @node_self.DEBUG_CODE.SCENE_FLAG
      main
    end # initialize
    def main
      @node_self.Task :default do |o| o.Code do
        Window.drawFont(50,  10, "--#{File.dirname(m)}/#{File.basename(m)}--" , @font)
      end end
    end \# def
  end \# #{m}
end \# m
TTTEXT


# -----------------------------------------------
# 上書き警告なし
# 必ず _tree_create.rb でバックアップを取ること
# ----------------------------------------------
  file = m + ".rb"
  puts str
  open( file , "w").print str.toutf8
  puts "created...  #{file}"
end
