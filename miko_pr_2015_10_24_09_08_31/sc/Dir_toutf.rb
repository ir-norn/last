# -*- encoding: UTF-8 -*-
require "kconv"

require "./__backup.rb"


puts "__utf8__ . . . ."
gets


Dir["**/*.rb"].each do |m|
 p m
 mm = open(m,"r").read.toutf8 
 open(m,"w") do |f|
   f.print mm
 end
end
