

class Game_Scene01_class
  def constructor
    Load_Gamen()
    @dat = "大きなデータ"
  end
  def mainloop
    Window.draw(0,0,@dat)
  end
  def message_proc code , argv = []
    case code
    when KEY_0
    when KEY_1
    when KEY_2
    when LOAD_START
      puts :ロード開始
    when LOAD_END
      puts :ロードend
    end
  end
end


class　Game_Object01_class
  def constructor
    @dat = "データ"
  end
  def mainloop
    Window.draw(0,0,@dat)
  end
  def message_proc code , argv = []
    case code
    when EVENT01
    when EVENT02
    when EVENT03
    end
  end
end



class AnneRose_Title_main
  def main
    # 必要に応じてロード
    Data_Load
    img = "大きなデータ"
    p 435
  end
  def mainloop
    Window.drawFont(50,  10, "--AnneRose/title--" ,)
  end
  def Event_proc code
    case code
    when VK_0
    when VK_1
    when VK_2
    end
  end
end
