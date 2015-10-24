# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__

module Patchouli_Knowledge
  module Item
    class << self
    end
  end
end



module Patchouli_Knowledge
  module Item
    class << self
      def default o
        
      end
      def spell_add o
        tmp = o.class.new 
        tmp.d = Image.load("img/dote/Item.png")
#        tmp.d = Image.new(50,50,[200,200,200,140])
        x , y = Lumia.get_xy_center( o , tmp )
        phase = 0
        miko.miko({ sym: :item , d: tmp.d  ,
           x: x , y: y ,
         }) do |o|
           case phase 
           when 0
             o.y -= 1
             if o.y < 20
               phase =1
             end
           when 1
             o.y += 1
           end
         end
        
      end

    end # ccc
  end # m
end # mp





module Patchouli_Item



end










