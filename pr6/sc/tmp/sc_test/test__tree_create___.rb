require"yaml"
require "pp"

data = YAML.load_file("./sc_test/meta_conf.yaml")
# pp data

$nest = 0
$buf="";$buf << <<-TTT
Tree_task.new.Main :AnneRose_main do | o |
  o.Code do
    if o.task.empty?
      o.Flandoll << :title
    end
    case o.Flandoll.pop
TTT
def f list , n
  p list.size
  $nest = [$nest , n].max
  list.each_with_index do | m , i |
      p m
#      exit
    if m.class == Array
      p 33
      exit
$buf << <<-TTT
  when :#{k} , :MSG_CODE#{1}
    o.Loop :#{k} do |o|
       AnneRose::#{k.capitalize}.new o
       o.Code do
         case o.Flandoll.pop
TTT
      v.each do |k,v|
        f({k => v} , n + 1) ;end
    else
      if n != $nest
         co = $nest - n
         $buf << "end " * 3 * co
         $buf << "\n"
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
  end #each
end # f
f( data[1] , 0 )
$buf << "end " * 3 * $nest
$buf << "end end end" #  main



#puts $buf


__END__

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
tree = "tree.rb"
if File.exists?( tree )
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