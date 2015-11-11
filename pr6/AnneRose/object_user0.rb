#coding:utf-8
require"dxruby"
if $0 == __FILE__  \
  and  (require "__dev/req")
  ARGV.replace [ *ARGV , [ 200 , 200 ] ]
  Dir.chdir File.dirname(File.expand_path(__FILE__))
end

x , y = ARGV.shift

Window.loop do | o , node_self |
  exit if Input.keyPush? K_F9
  Window.draw_font(50,100,"user0",Font.default)

  x += Input.x * 4
  y += Input.y * 4
  Window.draw_font(x,y,"◇",Font.default)

  if Input.key_push? K_Z
    xx ,yy =  + rand(600) , rand(400)
#    o.Task :__window_update_dym do |o| o.Code do
#       Window.draw_font(xx,yy,"◇",Font.default)
#      p o.hash
#    end end
    # p o.sym
    # p o.task.size
    # p o.up.sym
    # p o.up.task.size
#    exit
#    o.up.Flandoll << :object_user_shot0
    node_self.Flandoll << :object_user_shot0
    ARGV.replace [ *ARGV , [ x , y , 3 , 0]  ]
  end

  if Input.key_push? K_Q
#    p o.up.sym
    node_self.delete
  end
  if Input.key_push? K_Z
#    o.up.Flandoll << :object_user_shot0
#    ARGV.replace [ *ARGV , [ 300 , 300 , 3 , 0]  ]
  end

end
