log = system"racc -o sample_racc_1.rb sample_racc_1.racc"
( p "err" ; exit ) if not log


require './sample_racc_1'
calc = Calc.new()
p calc.parse(" 4 + [ 10 v2 ] + ( 2 + 2 + 2 ) ")

