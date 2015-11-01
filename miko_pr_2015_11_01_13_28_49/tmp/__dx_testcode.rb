require 'dxruby'


x = loop.lazy.map do
  p 1
end
x.next
