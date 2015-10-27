
module DEBUG_CODE_m
  class DEBUG_CODE_CLASS
    attr_accessor :MAIN_LOOP_FLAG , :ERROR_MESSAGE_FLAG , :SCENE_FLAG ,
    :DESTRUCTER_FUNC , :DESTRUCTER_CALL_FLAG
    def initialize
      @MAIN_LOOP_FLAG        = true
      @ERROR_MESSAGE_FLAG    = true
      @SCENE_FLAG            = true
      @DESTRUCTER_CALL_FLAG  = true
      @DESTRUCTER_FUNC  = ->{}
      @STATIC_LOGIC_var = ->{_={};->{ _[caller.to_s] ? false : _[caller.to_s] = true }}.call
    end
    def STATIC_LOGIC
     @STATIC_LOGIC_var.call
    end
    def DESTRUCTER &b
      self.DESTRUCTER_FUNC = b
    end
    # 設計上に問題あり、デストラクタが複数回呼ばれるので ->{} Dummyが必要
    def DESTRUCTER_CALL o
      o.task.values.each &:delete
      self.DESTRUCTER_FUNC.call
      self.DESTRUCTER_FUNC = ->{}
    end
    def SCREENSHOT_CALL
    end
  end # end-class
  # --- mixin ---
  attr_accessor :DEBUG_CODE
  def initialize *arg , &block
    super *arg , &block
    @DEBUG_CODE = DEBUG_CODE_CLASS.new
  end
  def delete # Merkle_tree( call super ) -- OVER_RIDE
    self.DEBUG_CODE.DESTRUCTER_CALL self if self.DEBUG_CODE.DESTRUCTER_CALL_FLAG
    super
  end
end
