
# ----------------------------- array  rot  lib --------------------------------

def array_rot45 vv
  vv.transpose.each_with_index.map do | m , i |
    [nil]*i + m + [nil]*((vv.size-1) - i)
  end.transpose.map(&:compact)
end

=begin

class Array
  def size_m1
    size - 1
  end
end

def array_rot45 vv
  v = vv.map(&:clone)
  a = []
  (0..v.size_m1*2).map do | m |
    a.unshift v.shift 
    a.compact!
    a -= [[]] 
    a.map(&:shift)
  end
end

=end




def array_rot45_decode a
  z = a.map(&:size).max
  a.each_with_index.inject( z.times.map do [] end ) do | c , ( m , i ) |
    z.times.each_with_object c do | k |
      if (k...(z+k)) === i
        if c[k].size != z
          c[k].push m.pop
        end
      end
    end
  end
end



def array_rot_print v
  v.map(&:to_s).each do | m |
    puts m.rjust(  m.size/2 + v.size + 5 ) 
  end
end


def array_rot n , v
  case n
    when 0 , 360
      v
    when 90
      v.transpose.map(&:reverse)
    when 180
      v.map(&:reverse).reverse
    when 270
      v.map(&:reverse).transpose
    when 45
      array_rot45 v
    when 135
      array_rot45 v.reverse.transpose
    when 225
      array_rot45 v.map(&:reverse).reverse
    when 315
      array_rot45 v.map(&:reverse).transpose
    else
     p "err"
  end
end

def array_rot_decode n , v
  case n
    when 0 , 360
      v
    when 90
      v.map(&:reverse).transpose
    when 180
      v.map(&:reverse).reverse
    when 270
      v.transpose.map(&:reverse)
    when 45
      array_rot45_decode v
    when 135
      array_rot45_decode(v.reverse).map(&:reverse)
    when 225
      array_rot45_decode v.map(&:reverse).reverse
    when 315
      array_rot45_decode(v).transpose.map(&:reverse)
    else
     p "err"
  end
end


