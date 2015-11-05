
def check_obj ar
  ar.map do|m|
    m.delete!"@"
    case m
    when /^[0-9]+$/ then  [:int,m]
    when /^[a-z]+$/ then  [:method,m]
    else [:error,m]
    end
  end
end

def repl s
  if s =~ /do.*@(.*?do.*?end)/m   # nesting
#    p $1
    return repl s.sub!( $1 , repl($1) )
  else
  s =~ /(.*?)do(.*?)end/m
#  p $1 ;  p $2
  obj = $1 ; block = $2
  r = /\.|\s/
  p obj_ar   = obj.split(r)
  p block_ar = block.split(r)
  p check_obj(obj_ar)
  p check_obj(block_ar)
  end
  return ""
end
s = DATA.read
#DATA.read.each_line.each_with_index.map do|m,i|
#  "!!!#{i}!!!#{m}"
#end.join
s.gsub!("\n","@")
repl s

__END__
1.times do
print a
2.times do
print b
3.times do
print c
end
end
end
