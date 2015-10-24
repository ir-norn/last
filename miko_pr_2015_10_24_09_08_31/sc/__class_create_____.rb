# -*- encoding: UTF-8 -*-
require "kconv"
require "Time"


ARGV.each do |m|


str = <<-TTT
\# -*- encoding: UTF-8 -*-
#
require "__tewi/req"  if $0 ==__FILE__
\#
\# #{Time.now}
\# ---------------------------------------- #{m} ----------------------------------------
module AnneRose
  class #{File.basename(m).capitalize}
		attr_accessor :node_self, :font
		def initialize _
      @node_self = _
      @font      = Font.new 30
      node_self.Task :default_code do |o|  o.Code do
        node_self.Flandoll << :MSG_CODE1 if Input.keyPush? K_1
				node_self.Flandoll << :MSG_CODE2 if Input.keyPush? K_2
				node_self.Flandoll << :return    if Input.keyPush? K_8
        node_self.up.delete              if Input.keyPush? K_9
        node_self.Scarlet = {
					:return => :default ,
					:test_data => "test_data_by:\#{node_self.sym}" }
      end end
      main
    end # initialize
    def main
			node_self.Task :default do |o|  o.Code do
				Window.drawFont(50,  10, "--#{m}--"   , @font)
      end end
    end \# def
  end \# #{m}
end \# m
TTT

  puts str


  begin
    open( m + ".rb")
    p "file exist"
  rescue
    open( m + ".rb" , "w").print str.toutf8
    p "file create #{m}"
    puts %!require dir + "in/Menu"!
  end

end
