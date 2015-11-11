#coding:utf-8
require "yaml"
data = YAML.load open("data.yaml")
data["text"].map.each_with_index.inject [] do |r,((inp,*out),i)|
  if r.include? inp
    print "yaml:" , i , ":" , inp , "\n" ;
    p :err
    exit
  end
  r + [inp]
end
