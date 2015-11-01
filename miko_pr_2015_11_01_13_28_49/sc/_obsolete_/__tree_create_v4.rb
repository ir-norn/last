require"yaml"
require "pp"

# Dir.chdir File.dirname(File.expand_path(__FILE__))+"/"
data = YAML.load_file("./sc/meta_conf.yaml")
pp data
p "-- yaml settings result --"
p out_file = data["out_file"]
p Project_name = data["project_name"]
p data["replace_project"]
p data["replace_tree"]


$nest = 0
$buf=""; $buf << <<-TTTEXT
#coding:utf-8
#
# ----------------------------------------------------------------
#
# - #{Time.now.strftime("%F | %X")}
# - meta script | #{__FILE__}
#
 require "__dev/req" if $0 ==__FILE__
# ----------------------------------------------------------------


# --- Merkle_tree ---

Merkle_tree.new.Main :#{Project_name}_main do | o |
  o.Code do
    case
    when o.task.empty? then o.Flandoll << :title
    end
    case o.Flandoll.pop
TTTEXT

END_add = 6

def f hs , n

# end add
  $nest = [$nest , n].max
  hs.each.with_index 1 do | (k,v),i|
  if n != $nest
     co = $nest - n
     $buf << "end " * END_add * co ; $buf << "\n"
     $nest -= co
  end
# -----------------

when_main = <<-TTTEXT
when nil then true
when -> rb do p :def ; false end
when -> rb do
  o.Task :"\#{rb}" do |o|
    o.Code do
      o.Main :"\#{rb}_main" do |o|
        Merkle_default_class.new o , rb , "#{Project_name}"
TTTEXT
when_main.chomp!
  if v.class == Hash
$buf << <<-TTTEXT
      #{when_main}
       o.Code do
         case o.Flandoll.pop
TTTEXT
      f v , n + 1  #  ---------------- rec ----------------
    else
$buf << <<-TTTEXT
         #{when_main}
           o.Code do end
           end
        end
      end
    end
TTTEXT
    end # els

  end # each
end # f
f( data["top"] , 0 )
$buf << "end " * END_add * $nest
$buf << "end end end" #  main
#$buf << " end" #  meta script v4_5 で追加

# ------------ indent
# TODO when..
nil while $buf.gsub!("end end","end\nend")
indent = 1
$buf =
$buf.each_line.inject "" do | ret , m |
  m.strip! ; m <<  "\n"
  if m[0] != "#" # comment
    if m =~ /end|when/       then indent -= 1 end
      ret << "  " * indent if indent > 0
    if m =~ /\sdo|case|when/   then indent += 1 end

#    if m =~ /Code.*?do.*?end/  then indent -= 1 end
    if m =~ /when.*?do/        then indent += 1 end
    if m =~ /when.*?do.*?end/  then indent -= 1 end
  end
  ret << m
end

# puts $buf
# exit
# -- backup ---------
system"xcopy #{Project_name} __meta_tmp\\#{Project_name}"
system"xcopy #{out_file} __meta_tmp\\#{out_file}"

#exit
# ---------------- file create ------------------------------
if data["replace_tree"]
  puts $buf
  puts "created #{out_file} "
  open( out_file , "w").print $buf
end

#system "ruvi tree.rb"

# --------------  scene meta
# def me hs , b = []
#   hs.map do|k,v|
#     b << k
#     (me v , b) if v
#   end ; return b
# end
# puts me(data["top"])

# -----------------------------------------------------------------
# --------------------- replace project -------------------------
# -----------------------------------------------------------------
# exit
# if data["replace_project"]
#   system"md #{Project_name}"
#   me(data["top"]).each do |file|
#     system "ruby sc\\__scene_create.rb replace #{Project_name}\\#{file}"
#   end
# end
