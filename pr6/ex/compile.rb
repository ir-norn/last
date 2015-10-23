# -*- encoding: UTF-8 -*-
require "dl/import"
require 'Win32API'

#---------------------------------------------------------
# ファイル末尾でディレクトリ情報を戻す
# dll作成の為に作業ディレクトリを変更
#
unless $0 == __FILE__
  pwd = Dir.pwd
  Dir.chdir Yuyuko.TOPDIR + "/"+File.basename(File.dirname(__FILE__))+"/"
end
#
#
#-------------------------------------------------------------------------------









class RubyC
  def initialize hs
    @@filenum = 0
    @src      = hs[:src]      || nil
    @file     = hs[:file]     || "__test__#{@@filenum}"
    @err_msg  = hs[:err_msg]  || ""
    @@filenum+=1
  end
  def compile
    #コンパイルする必要なしのとき
    unless open("#{@file}_log.txt" , "r").read =~ /(error)/
      return true if open("#{@file}.c" , "r").read == @src
      return true if @src.nil?
    end if File.exist? "#{@file}.dll"
    #コンパイル、ログ書き込み
    open("#{@file}.c" , "w") do |f| f.print @src end
   `bcc32 -c #{@file}.c               > #{@file}_log.txt`
   `bcc32 -tWD #{@file}.obj          >> #{@file}_log.txt`
   `implib #{@file}.lib #{@file}.dll >> #{@file}_log.txt`
    File.unlink "#{@file}.lib" if File.exist? "#{@file}.lib"
    File.unlink "#{@file}.obj" if File.exist? "#{@file}.obj"
    File.unlink "#{@file}.tds" if File.exist? "#{@file}.tds"
    #エラーログ書き込み
    open("#{@file}_log.txt" ,"a") do |f|
      f.print "<caller>\n"
      f.print caller*"\n"
      f.print "\n#{@err_msg}\n"
      f.print "</caller>\n"
    end
    log = open("#{@file}_log.txt" , "r").read
    unless log =~ /(error)/
      return true
    end
    puts log
#    log.scan(/(エラ.*)|(警告.*)|(errors.*)/) do |m|
#    log.scan(/(エラ.*)|(警告.*)/) do |m|
#      puts m.compact
#    end
#    log.scan(/(<caller>.*<\/caller>)/m) do |m|
 #     puts m
#    end
    return false
  end

  def call name , *h
    hik = ""
    h.size.times do |n|
      if h[n].class == String
        hik << "p"
      else
        hik << "i"
      end
    end
#    hik = "p"*h.size
    @dll_func_temp ||= Hash.new
    @dll_func_temp.store( name ,
       Win32API.new("#{@file}.dll", "_" + name.to_s, hik, "i")
       )
    @dll_func_temp[ name ].call *h
  end
  def read file = @file
    @dll_func_temp ||= Hash.new
    @dll_func_temp.store( name ,
       Win32API.new("#{file}.dll", "_" + name.to_s, hik, "i")
       )
  end
  def run
    
  end
end





rr = RubyC.new({
  :file     => "Last_Lib" , 
  :err_msg  => "---" ,   
  :src      => src = <<-SRC
  #include <stdio.h>
  #include <math.h>
  #include <windows.h>
// ------------ main --------------------
  int _export func(char*str)
  {
    printf( str );
    return 0;
  }
  double _export DegToRad( double x )
  {
    return x*M_PI/180;
  }
  double _export RadToDeg( double x )
  {
    return x*180/M_PI;
  }
  double _export firstatan( double x , double y , double xxx , double yyy )
  {
//    if ( ( (yyy - y) + (xxx - x) ) == 0)
//       return RadToDeg( atan2( 1+rand()%3 , 1+rand()%3 ) );
    return RadToDeg( atan2( yyy - y , xxx - x ) );
  }
/*
  def DegToRad x
    x*Math::PI/180
  end
  def RadToDeg x
    x*180/Math::PI
  end
  def firstatan x , y, xxx, yyy
     return RadToDeg( Math.atan2( yyy - y , xxx - x ))
  end
*/
SRC

})
rr.compile
#rr.call :func , "aaa"




module Last_Lib
  extend DL::Importer
  dlload "Last_Lib.dll"

#  typealias('double', 'int*')
  extern "int _func(char* str)"
  extern "double _firstatan( double  , double  , double , double )"
  extern "double _DegToRad( double )"
  extern "double _RadToDeg( double )"

  def self.init
    self.singleton_methods.sort.grep(/^_/).each do | m |
      self.singleton_class.instance_eval do
        alias_method m[1..-1] ,  m
      end
    end
  end

Last_Lib.methods.sort.grep(/_/).each do | m |
  Last_Lib.singleton_class.instance_eval do
#    alias_method m[1..-1] ,  m
    Last_Lib.module_eval do
      define_method m[1..-1] do | *h |
        eval "Last_Lib.#{m} *h "
      end
    end
  end
end




# ----- run -----
  self.init
end
#p Last_Lib.RadToDeg 30

#Last_Lib.func "test"
#Last_Lib._func "test"







# ----------------------------- 作業ディレクトリを元に戻す ----------------------------------------------
#
unless $0 == __FILE__
  Dir.chdir pwd
end
#
#--------------------------------------------------------------------------------------------------







