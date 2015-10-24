require"yaml"
require "pp"

data = YAML.load_file("meta_conf.yaml")
# pp data

$nest = 0
$buf = ""
$buf << <<-TTT
Tree_Diagram.new.Main  $Scarlet.TOP_SYM = Yuyuko.top_sym do | o |
  $Scarlet.TOP_NODE = o
  Yuyuko.TOP_NODE = o
  o.Code do
    if o.task.empty?
      o.Flandoll << :title
    end
    case o.Flandoll.pop
TTT
#puts $buf
def f hs , n
$nest = [$nest , n].max
  hs.each do |k,v|
    if v
$buf << <<-TTT
  when :#{k}
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
#      puts $buf
    end # els
  end
end
f( data["top"] , 0 )
$buf << "end " * 3 * $nest

$buf << "end end end"
puts $buf

__END__
case o.Flandoll.pop
when :option
  o.Loop :option do |o|
    AnneRose::Option.new o
    o.Code do end
  end #
when :exit
