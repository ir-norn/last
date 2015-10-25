require"yaml"
require "pp"

data = YAML.load_file("meta_conf.yaml")
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
# this file creating meta
#
# - #{Time.now.strftime("%F | %X")}
# - meta script is #{__FILE__}
#
# ----------------------------------------------------------------

# --- meta tree ---

Merkle_tree.new.Main :#{Project_name}_main do | o |
  o.Code do
    if o.task.empty?
      o.Flandoll << :title
    end
    case o.Flandoll.pop
TTTEXT
def f hs , n

# end add
  $nest = [$nest , n].max
  hs.each.with_index 1 do | (k,v),i|
  if n != $nest
     co = $nest - n
     $buf << "end " * 3 * co ; $buf << "\n"
     $nest -= co
  end
# -----------------
  if v.class == Hash
$buf << <<-TTTEXT
  when :#{k} , :MSG_CODE#{i}
    o.Loop :#{k} do |o|
       #{Project_name}::#{k.capitalize}.new o
       o.Code do
         case o.Flandoll.pop
TTTEXT
      f v , n + 1  #  ---------------- rec ----------------
    else
$buf << <<-TTTEXT
  when :#{k}, :MSG_CODE#{i}
        o.Loop :#{k} do |o|
           #{Project_name}::#{k.capitalize}.new o
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
$buf.each_line.inject "" do | ret , m |
  m.strip! ; m <<  "\n"
  if m =~ /do|case|if/ then $do_case_if += 1 end
  if m =~ /end/        then $do_case_if -= 1 end
  ret << "  " * $do_case_if  ; ret << m
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
def me hs , b = []
  hs.map do|k,v|
    b << k
    (me v , b) if v
  end ; return b
end
puts me(data["top"])

# -----------------------------------------------------------------
# --------------------- replace project -------------------------
# -----------------------------------------------------------------
# exit
if data["replace_project"]
  system"md #{Project_name}"
  me(data["top"]).each do |file|
    system "ruby sc\\__scene_create.rb replace #{Project_name}\\#{file}"
  end
end
