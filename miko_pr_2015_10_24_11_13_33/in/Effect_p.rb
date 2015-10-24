# -*- encoding: UTF-8 -*-
require "__tewi/req"  if $0 ==__FILE__

module Patchouli_Knowledge
  module Effect
    class << self
    end
  end
end




module Patchouli_Knowledge
  module Effect
    class << self
      def economy_rand 
        rand(7)
      end
      
      def default o
        
      end
      #
      #
      #
      # rand sym_uniq でエフェクト節約
      #
      def ef0 o
        ang = [70,80,90,110,120].sample
        tmp = o.class.new 
        tmp.d = $Scarlet.dd.effect0
        x , y = Lumia.get_xy_center( o , tmp )
        i = economy_rand
        miko.miko({
          sym_uniq: "effect_ef_#{i}" , x: x , y: y, d: tmp.d,
#          sym: :effect , x: x , y: y, d: tmp.d,
          angle: ang , speed: rand(2)+0.5 ,
          alpha:  ({ type: :default, start: 150 , limit: 5 , add: -1  }) ,
          rot:    ({ type: :default, start: 0   , limit: 900 , add: 1  }) ,
         }) do |o|
           case o.c
           when 100
             o.delete
           end
        end # m
        #
      end # ef0
      
      
      #
      #
      # 
      # ちょっとeach.with_index とか　sym_uniq によってオブジェクト数の節約
      #
      def enemy_de o
        economy = rand(10)
        0.step(360,45).each.with_index( economy ) do | ang , i |
          tmp = o.class.new 
          tmp.d = Image.new(100,100,[240,220,140,140])
          x , y = Lumia.get_xy_center( o , tmp )

          miko.miko({
            sym_uniq: "effect_de#{i}" , x: x , y: y, d: tmp.d,
            angle: ang , speed: rand(4)+0.5 ,
            alpha:  ({ type: :default, start: 150 , limit: 5 , add: -1  }) ,
            rot:    ({ type: :default, start: 900 , limit: 0 , add: -1  }) ,
           }) do |o|
             o.Init do
               o.delete_lazy 120
             end
             case o.c
             when 100
             end
             
          end # m
        end # ste        
      end # d

      def ef_enemy_shot o
        ang = [70,80,90,110,120].map{|n|n+180}.sample
        tmp = o.class.new 
        tmp.d = $Scarlet.dd.effect2
        x , y = Lumia.get_xy_center( o , tmp )
        i = economy_rand
        miko.miko({
          sym_uniq: "effect_ef_shot#{i}" , x: x , y: y, d: tmp.d,
#          sym: :effect , x: x , y: y, d: tmp.d,
          angle: ang , speed: rand(2)+0.5 ,
          alpha:  ({ type: :default, start: 150 , limit: 5 , add: -1  }) ,
          rot:    ({ type: :default, start: 900 , limit: 0 , add: -1  }) ,
         }) do |o|
           case o.c
           when 100
             o.delete
           end
        end # m
      end # df

      def tokuten_de o
        ang = rand(360)
        tmp = o.class.new 
        tmp.d = $Scarlet.dd.effect2
        x , y = Lumia.get_xy_center( o , tmp )
        miko.miko({
          sym_uniq: :effect , x: x , y: y, d: tmp.d,
#          sym: :effect , x: x , y: y, d: tmp.d,
          angle: ang , speed: rand(2)+0.5 ,
          alpha:  ({ type: :default, start: 150 , limit: 5 , add: -1  }) ,
          rot:    ({ type: :default, start: 900 , limit: 0 , add: -1  }) ,
         }) do |o|
           case o.c
           when 100
             o.delete
           end
        end # m
      end

    end # ccc
  end # m
end # mp



