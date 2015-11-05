#coding:utf-8
require "yaml"
data = YAML.load DATA.read
# puts data["一人称"]
# p data["text"]

# mehotd
def ruiji input ; input end

# input
input = "かわいいね"
print ">" , input  , "\n"

# out each
data["in_out"].each do| (inp , out) |
  # if ruiji(input , inp)
  if input == inp
    print "幽々子様>" , out , "\n"
  end
end

# hi to ri go to
data["out"].each do| out |
  print "幽々子様>" , out , "\n"
  break
end



__END__
一人称:
  - my
  - 私
  - わたし
in_out:
  - [ おはよう , ごきげんよう ]
  - [ かわいいね , ありがとう ]
  - [ かわいいよ , いえいえ ]
out:
  - わたしは世界で最も可愛い幽々子ちゃんです
  - 美しい・・・
  - 私って綺麗？
