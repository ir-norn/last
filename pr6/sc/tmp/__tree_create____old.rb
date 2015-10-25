require"yaml"
require "pp"

data = YAML.load_file("meta_conf.yaml")
pp data

$nest = 0
$buf = ""
$buf << <<-TTT
Tree_task.new.Main :AnneRose_main do | o |
  o.Code do
    if o.task.empty?
      o.Flandoll << :title
    end
    case o.Flandoll.pop
TTT
def f hs , n
  $nest = [$nest , n].max
  p hs.size
      hs.each.with_index 1 do | (k,v),i|
#      k = hs.keys.first
#      v = hs.values.first
    if v
$buf << <<-TTT
  when :#{k} , :MSG_CODE#{1}
    o.Loop :#{k} do |o|
       AnneRose::#{k.capitalize}.new o
       o.Code do
         case o.Flandoll.pop
TTT
     f v , n + 1
#      v.each do |k,v|
#        f({k => v} , n + 1) ;end
    else
      if n != $nest
         co = $nest - n
         $buf << "end " * 3 * co
         $buf << "\n"
         $nest -= co
      end

      $buf << <<-TTT
    when :#{k}, :MSG_CODE#{i}
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

# puts $buf
# indent
loop do break unless $buf.gsub!("end end","end\nend") end
$do_case_if = 1
$buf =
$buf.each_line.to_a.compact.map do |m|
  m.strip!
  m <<  "\n"
  if m =~ /do|case|if/
    $do_case_if += 1
  end
  if m =~ /end/
    $do_case_if -= 1
  end
#  p  $do_case_if
  ret = ""
  ret << "  " * $do_case_if
  ret << m
end.join

#puts $buf
#exit

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
