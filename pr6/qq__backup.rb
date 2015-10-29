# -*- encoding: UTF-8 -*-
#!ruby -Ks
t = Time.now.strftime("%Y_%m_%d_%H_%M_%S")
dir = File.basename File.dirname __FILE__

puts "backup_start..."

miko = "miko_pr_"

`mkdir ..\\#{ miko }#{ t }`
`xcopy ..\\#{dir} ..\\#{ miko }#{ t } /E /Y`

puts "complate..."




