
__END__


# array just ?

class Array 
  def rjust n , s = nil
    return self + [s] * ( n - size )  if (n - size) > 0
    self
  end
  def ljust n , s = nil
    return [s] * ( n - size ) + self  if (n - size) > 0
    self
  end
end
h = [1,2,3]
c = h.each.with_index(1).map do | m , i |
   [m].ljust( i ).rjust(h.size)
end

p *c

p [1,2,3].rjust(5)
p [1,2,3].ljust(5)

# [1, nil, nil]
# [nil, 2, nil]
# [nil, nil, 3]
# [1, 2, 3, nil, nil]
# [nil, nil, 1, 2, 3]


