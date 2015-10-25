# -*- encoding: UTF-8 -*-
# ruby 1.9.3p448 (2013-06-27) [i386-mingw32]
#
require "dxruby"
require "dxrubyex"
require "yaml"
# dir
Dir.chdir File.dirname(File.expand_path("../pr6",__FILE__))+"/"
# p Dir.pwd
dir = "./"
# ------------- expansion -------------------------
require dir + "ex/ruby_ex"
require dir + "ex/dxruby_ex"
# --- Lib ---
# lib
module Create_method_uniq_sym
	class << self
		def extended o
			o.var_add :uniq_sym
			o.uniq_sym     = c_uniq_sym
		end
		def c_uniq_sym
		  _=0;->{ return "_uniq_#{_+=1}".to_sym }
		end
  end
end

# --- const --
require dir + "const"
# ------------- task -------------------------
require dir + "yk/tree_task_search"
require dir + "yk/tree_task"
# -- scene lib
# -- scene
# -- tree
Dir[dir + "AnneRose/*.rb"].map do |m| require m end

require dir + "Merkle_tree_meta"
