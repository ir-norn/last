require"dxruby"

    a=[
      "Comic Sans MS" ,
      "Meiryo UI" , 
      "FixedSys" ,
      "Courier" ,
      "Impact" ,
    ].each.with_index(2).map do |f,i|
      1.upto(20).map do |m|
          p "[ :font#{i}_#{m*10} , "
          p eval( %!Font.new(#{m*10}, "#{f}")! )
          p "]"
          exit
#         str= %![ :font#{i}_#{m*10} , Font.new(#{m*10}, "#{f}" ) ] !
#         p str
#         [ eval( str ) , "," ].join
    
      end
    
    end
  p a


exit

require"dxruby"
a=[
:font2_10                , Font.new(10, "Comic Sans MS" ) ,
:font2_20                , Font.new(20, "Comic Sans MS" ) ,
:font2_30                , Font.new(30, "Comic Sans MS" ) ,
:font2_40                , Font.new(40, "Comic Sans MS" ) ,
:font2_50                , Font.new(50, "Comic Sans MS" ) ,
:font2_60                , Font.new(60, "Comic Sans MS" ) ,
:font2_70                , Font.new(70, "Comic Sans MS" ) ,
:font2_80                , Font.new(80, "Comic Sans MS" ) ,
:font2_90                , Font.new(90, "Comic Sans MS" ) ,
:font2_100                , Font.new(100, "Comic Sans MS" ) ,
:font2_110                , Font.new(110, "Comic Sans MS" ) ,
:font2_120                , Font.new(120, "Comic Sans MS" ) ,
:font2_130                , Font.new(130, "Comic Sans MS" ) ,
:font2_140                , Font.new(140, "Comic Sans MS" ) ,
:font2_150                , Font.new(150, "Comic Sans MS" ) ,
:font2_160                , Font.new(160, "Comic Sans MS" ) ,
:font2_170                , Font.new(170, "Comic Sans MS" ) ,
:font2_180                , Font.new(180, "Comic Sans MS" ) ,
:font2_190                , Font.new(190, "Comic Sans MS" ) ,
:font2_200                , Font.new(200, "Comic Sans MS" ) ,
:font3_10                , Font.new(10, "Meiryo UI" ) ,
:font3_20                , Font.new(20, "Meiryo UI" ) ,
:font3_30                , Font.new(30, "Meiryo UI" ) ,
:font3_40                , Font.new(40, "Meiryo UI" ) ,
:font3_50                , Font.new(50, "Meiryo UI" ) ,
:font3_60                , Font.new(60, "Meiryo UI" ) ,
:font3_70                , Font.new(70, "Meiryo UI" ) ,
:font3_80                , Font.new(80, "Meiryo UI" ) ,
:font3_90                , Font.new(90, "Meiryo UI" ) ,
:font3_100                , Font.new(100, "Meiryo UI" ) ,
:font3_110                , Font.new(110, "Meiryo UI" ) ,
:font3_120                , Font.new(120, "Meiryo UI" ) ,
:font3_130                , Font.new(130, "Meiryo UI" ) ,
:font3_140                , Font.new(140, "Meiryo UI" ) ,
:font3_150                , Font.new(150, "Meiryo UI" ) ,
:font3_160                , Font.new(160, "Meiryo UI" ) ,
:font3_170                , Font.new(170, "Meiryo UI" ) ,
:font3_180                , Font.new(180, "Meiryo UI" ) ,
:font3_190                , Font.new(190, "Meiryo UI" ) ,
:font3_200                , Font.new(200, "Meiryo UI" ) ,
:font4_10                , Font.new(10, "FixedSys" ) ,
:font4_20                , Font.new(20, "FixedSys" ) ,
:font4_30                , Font.new(30, "FixedSys" ) ,
:font4_40                , Font.new(40, "FixedSys" ) ,
:font4_50                , Font.new(50, "FixedSys" ) ,
:font4_60                , Font.new(60, "FixedSys" ) ,
:font4_70                , Font.new(70, "FixedSys" ) ,
:font4_80                , Font.new(80, "FixedSys" ) ,
:font4_90                , Font.new(90, "FixedSys" ) ,
:font4_100                , Font.new(100, "FixedSys" ) ,
:font4_110                , Font.new(110, "FixedSys" ) ,
:font4_120                , Font.new(120, "FixedSys" ) ,
:font4_130                , Font.new(130, "FixedSys" ) ,
:font4_140                , Font.new(140, "FixedSys" ) ,
:font4_150                , Font.new(150, "FixedSys" ) ,
:font4_160                , Font.new(160, "FixedSys" ) ,
:font4_170                , Font.new(170, "FixedSys" ) ,
:font4_180                , Font.new(180, "FixedSys" ) ,
:font4_190                , Font.new(190, "FixedSys" ) ,
:font4_200                , Font.new(200, "FixedSys" ) ,
:font5_10                , Font.new(10, "Courier" ) ,
:font5_20                , Font.new(20, "Courier" ) ,
:font5_30                , Font.new(30, "Courier" ) ,
:font5_40                , Font.new(40, "Courier" ) ,
:font5_50                , Font.new(50, "Courier" ) ,
:font5_60                , Font.new(60, "Courier" ) ,
:font5_70                , Font.new(70, "Courier" ) ,
:font5_80                , Font.new(80, "Courier" ) ,
:font5_90                , Font.new(90, "Courier" ) ,
:font5_100                , Font.new(100, "Courier" ) ,
:font5_110                , Font.new(110, "Courier" ) ,
:font5_120                , Font.new(120, "Courier" ) ,
:font5_130                , Font.new(130, "Courier" ) ,
:font5_140                , Font.new(140, "Courier" ) ,
:font5_150                , Font.new(150, "Courier" ) ,
:font5_160                , Font.new(160, "Courier" ) ,
:font5_170                , Font.new(170, "Courier" ) ,
:font5_180                , Font.new(180, "Courier" ) ,
:font5_190                , Font.new(190, "Courier" ) ,
:font5_200                , Font.new(200, "Courier" ) ,
:font6_10                , Font.new(10, "Impact" ) ,
:font6_20                , Font.new(20, "Impact" ) ,
:font6_30                , Font.new(30, "Impact" ) ,
:font6_40                , Font.new(40, "Impact" ) ,
:font6_50                , Font.new(50, "Impact" ) ,
:font6_60                , Font.new(60, "Impact" ) ,
:font6_70                , Font.new(70, "Impact" ) ,
:font6_80                , Font.new(80, "Impact" ) ,
:font6_90                , Font.new(90, "Impact" ) ,
:font6_100                , Font.new(100, "Impact" ) ,
:font6_110                , Font.new(110, "Impact" ) ,
:font6_120                , Font.new(120, "Impact" ) ,
:font6_130                , Font.new(130, "Impact" ) ,
:font6_140                , Font.new(140, "Impact" ) ,
:font6_150                , Font.new(150, "Impact" ) ,
:font6_160                , Font.new(160, "Impact" ) ,
:font6_170                , Font.new(170, "Impact" ) ,
:font6_180                , Font.new(180, "Impact" ) ,
:font6_190                , Font.new(190, "Impact" ) ,
:font6_200                , Font.new(200, "Impact" ) ,
]


Window.loop do
  Window.drawFont  100,100,"test",a[21]

end

exit

[
  "Comic Sans MS" ,
  "Meiryo UI" , 
  "FixedSys" ,
  "Courier" ,
  "Impact" ,
].each.with_index(2) do |f,i|
  1.upto 20 do |m|
    puts %!:font#{i}_#{m*10}                , Font.new(#{m*10}, "#{f}" ) ,!

  end

end


