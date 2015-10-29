#coding:utf-8


obj = 'hoge'

ff = ->x{
 p x*2
 false
}
f = ->x{
 p x
 true
}
case obj #  ARGV.pop
when ->rb{ true }  # ->rb{ load rb }
when true # loadファイルが見つからない場合の例外
when ->rb{
  class A
     p 345353
  end

   p rb*2 ; false }
  puts 'is'
when f
  puts 'Num'
else
  puts 'els'
end

#=> Stringでしたよー
