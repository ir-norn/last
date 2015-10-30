#coding:utf-8


# def first_three n
#   [n].+([nil]*3).flatten[0..2]
# end
#
# def first_three((a, b, c))
#   [a, b, c]
# end
#
# p first_three 1 # => [1, nil, nil]
# p first_three [1] # => [1, nil, nil]
# p first_three [1, 2] # => [1, 2, nil]
# p first_three [1, 2, 3, 4, 5] # => [1, 2, 3]
#
# def sum_of_odd_mid h
#   h.each_slice(2).map do |a,b|
#     next 0 if not b
#     b[1]
#   end.inject(:+)
# #  h.each_slice(2).to_a.transpose
# end
# values = [[1,2,3],[4,5,6],[7,8,9],[10,11,12],[13,14,15],[16,17,18]
# ]
#
# def sum_of_odd_mid((_,(_,v1,_),_,(_,v2,_),_,(_,v3,_)))
#   v1 + v2 + v3
# end
#
# p sum_of_odd_mid(values) # => 33
#


obj = nil

ff = ->x{
 p x*2
 false
}
f = ->x{
 p x
 true
}
case obj #  ARGV.pop
when nil ; p 888
when ->rb{ false }  # ->rb{ load rb }
when true # loadファイルが見つからない場合の例外
when ->rb{


   p rb*2 ; false }
  puts 'is'
when f
  puts 'Num'
else
  puts 'els'
end

#=> Stringでしたよー
