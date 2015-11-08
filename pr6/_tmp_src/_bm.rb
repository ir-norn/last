
require "Benchmark"

a=->{
  str = "xxx"
  "_#{str}_"
}
b=->{
  str = "xxx"
  :"_#{str}_"
}
c=->{
  str = :xxx
  "_#{str}_"
}
d=->{
  str = :xxx
  :"_#{str}_"
}
N = 1000000
Benchmark.bm do |q|
  q.report(:a) {
    N.times { a.call }   }
  q.report(:b) {
    N.times { b.call }   }
  q.report(:c) {
    N.times { c.call }   }
  q.report(:d) {
    N.times { d.call }   }

end


# ruby 2.2.0p0 (2014-12-25 revision 49005) [i386-mswin32_100]
#        user     system      total        real
# a  0.563000   0.000000   0.563000 (  0.600774)
# b  0.812000   0.000000   0.812000 (  0.803892)
# c  0.719000   0.000000   0.719000 (  0.748026)
# d  0.937000   0.000000   0.937000 (  0.980407)
#
#
# ruby 2.2.3p173 (2015-08-18 revision 51636) [x64-mingw32]
# user     system      total        real
# a  0.438000   0.000000   0.438000 (  0.445316)
# b  0.531000   0.000000   0.531000 (  0.528190)
# c  0.515000   0.000000   0.515000 (  0.511472)
# d  0.610000   0.000000   0.610000 (  0.621590)
