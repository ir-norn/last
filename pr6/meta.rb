require"yaml"
require "pp"

data = YAML.load_file("meta_conf.yaml")
# pp data

$nest = 0
$buf = ""
$buf << <<-TTT
Tree_Diagram.new.Main :AnneRose_main do | o |
  o.Code do
    if o.task.empty?
      o.Flandoll << :title
    end
    case o.Flandoll.pop
TTT
def f hs , n
$nest = [$nest , n].max
  hs.each.with_index 1 do |(k,v),i|
    if v
$buf << <<-TTT
  when :#{k} , :MSG_TREE_CODE#{i}
    o.Loop :#{k} do |o|
       AnneRose::#{k.capitalize}.new o
       o.Code do
         case o.Flandoll.pop
TTT
      v.each do |k,v|
        f({k => v} , n + 1) ;end
    else
      if n != $nest
#        $buf <<  n.to_s ; $buf <<  $nest.to_s
         co = $nest - n
         $buf << "end " * 3 * co
         $nest -= co
      end

      $buf << <<-TTT
        when :#{k}
          o.Loop :#{k} do |o|
             AnneRose::#{k.capitalize}.new o
             o.Code do end
          end
      TTT
    end # els
  end # each
end # f
f( data["top"] , 0 )
$buf << "end " * 3 * $nest
$buf << "end end end" #  main

# indent
#  99.times do $buf.gsub!("end end","end\nend") end

# puts $buf

def me hs , b = []
  hs.map do|k,v|
    b << k
    me v , b if v
  end
  b
end
puts me(data["top"])
me(data["top"]).each do |file|
  system "ruby sc\\__class_create_____.rb   AnneRose\\#{file}"
end
