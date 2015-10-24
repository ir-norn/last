# -*- encoding: UTF-8 -*-
require "kconv"
r = ARGV[0]
if r.nil?
  p "r to nil"
  p "kensaku hikisuu sitei"
  exit
end
r = r.tosjis
Dir["**/*.rb"].each do |m|
  if open(m).read.tosjis =~ /#{r}/
    puts m
  end
end