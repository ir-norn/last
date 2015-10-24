require"yaml"
require "pp"

data = YAML.load_file("meta_conf.yaml")
# pp data

$nest = 0
$buf = ""
pp data

def f hs , n
  hs.each.with_index 1 do |(k,v),i|
	p hs.each.first[0]
	p k
    if v
      $buf << "A_#{i}\n"
      v.each do |k,v|
        f({k => v} , n + 1)
      end
    else
      $buf << "B_#{i}\n"
    end # els
  end # each
end # f
f( data["top"] , 0 )

puts $buf

