require"yaml"
require "pp"

data = YAML.load_file("meta_conf.yaml")
pp data

$nest = 0
$buf=""; $buf << <<-TTTEXT
Merkle_tree.new.Main :AnneRose_main do | o |
  o.Code do
    if o.task.empty?
      o.Flandoll << :title
    end
    case o.Flandoll.pop
TTTEXT
def f hs , n
  $nest = [$nest , n].max
  hs.each.with_index 1 do | (k,v),i|
  if n != $nest
     co = $nest - n
     $buf << "end " * 3 * co ; $buf << "\n"
     $nest -= co
  end

  if v.class == Hash
$buf << <<-TTTEXT
  when :#{k} , :MSG_CODE#{i}
    o.Loop :#{k} do |o|
       AnneRose::#{k.capitalize}.new o
       o.Code do
         case o.Flandoll.pop
TTTEXT
      f v , n + 1
    else
$buf << <<-TTTEXT
  when :#{k}, :MSG_CODE#{i}
        o.Loop :#{k} do |o|
           AnneRose::#{k.capitalize}.new o
           o.Code do end
        end
TTTEXT
    end # els
  end # each
end # f
f( data["top"] , 0 )
$buf << "end " * 3 * $nest
$buf << "end end end" #  main

# ------------ indent
nil while $buf.gsub!("end end","end\nend")
$do_case_if = 1
$buf =
$buf.each_line.to_a.compact.map do |m|
  m.strip! ; m <<  "\n"
  if m =~ /do|case|if/ then $do_case_if += 1 end
  if m =~ /end/        then $do_case_if -= 1 end
  ret=""; ret << "  " * $do_case_if  ; ret << m
end.join

puts $buf
 exit

# ---------------- file create ------------------------------
tree = "tree.rb"
if false
#if   File.exists?( tree )
  puts "#{tree} file _exists _error"
  exit
else
  puts $buf
  puts "created #{tree} "
  open( tree , "w").print $buf
end

#system "ruvi tree.rb"
#__END__

# --------------  scene meta
def me hs , b = []
  hs.map do|k,v|
    b << k
    me v , b if v
  end ; return b
end
puts me(data["top"])

me(data["top"]).each do |file|
  system "ruby sc\\__class_create_____.rb   AnneRose\\#{file}"
end
