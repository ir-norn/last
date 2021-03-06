require 'dxruby'

str = ""
Input::IME.enable=true
Window.loop do
  str += Input::IME.get_string
  Window.draw_font_ex(0, 0, str, Font.default)

  t = Input::IME.get_comp_info
  x = 0
  sx = nil
  t.comp_str.each_char.with_index do |s, i|
    case t.comp_attr[i]
    when Input::IME::ATTR_INPUT # 入力中
      Window.draw_font(x, 24, s, Font.default)
      sx ||= x
    when Input::IME::ATTR_TARGET_CONVERTED # 選択されてて変換されてる
      Window.draw_font(x, 24, s, Font.default, color:C_YELLOW)
      sx ||= x
    when Input::IME::ATTR_CONVERTED # 選択されてなくて変換されてる
      Window.draw_font(x, 24, s, Font.default, color:C_RED)  
    when Input::IME::ATTR_TARGET_NOTCONVERTED # 選択されてて変換されてない
      Window.draw_font(x, 24, s, Font.default, color:C_GREEN)
      sx ||= x
    end
    x += Font.default.get_width(s)
  end

  if t.can_list.size > 0
    t.can_list.each.with_index do |s, i|
      Window.draw_font(sx, 24*i+48, (i+1).to_s + " : " + s, Font.default, color:(t.selection == i ? C_YELLOW : C_WHITE))
    end
    Window.draw_font(0, 324, (t.selection_total+1).to_s + " / " + t.total.to_s, Font.default)
  end

  Window.draw_font(0, 300, "cursor pos : " + t.cursor_pos.to_s, Font.default)

  if Input.key_push?(K_ESCAPE)
    if str == ""
      break
    else
      str = ""
    end
  end
end

 lp�