


def __fead_inout_create_sub o , hs = Hash.new
   [ :rot , :scalex , :scaley , :alpha ]
   .each do |m|
     if hs[m].class == Array
       au = hs[m].clone
       hs[m] = Hash.new
       hs[m][:type]  = au[0]
       hs[m][:start] = au[1]
       hs[m][:limit] = au[2]
       hs[m][:add]   = au[3]
     end
   end
   o.extend Module.new{ attr_accessor :st }

   require 'ostruct'
   o.st = OpenStruct.new

   o.x      = hs[:x]
   o.y      = hs[:y]
   o.d      = hs[:d]
   o.st.fade_z   = hs[:z] || 0
   hs_rot    = hs[:rot]    || Hash.new
   hs_scalex = hs[:scalex] || Hash.new
   hs_scaley = hs[:scaley] || Hash.new
   hs_alpha  = hs[:alpha]  || Hash.new

   o.st.rot_hik    = ({  type:  hs_rot[:type]     || :default , start:  hs_rot[:start]    || 0   , limit:  hs_rot[:limit]    || 0 , add: hs_rot[:add]    || 0 })
   o.st.scalex_hik = ({  type:  hs_scalex[:type]  || :default , start:  hs_scalex[:start] || 1   , limit:  hs_scalex[:limit] || 1 , add: hs_scalex[:add] || 0 })
   o.st.scaley_hik = ({  type:  hs_scaley[:type]  || :default , start:  hs_scaley[:start] || 1   , limit:  hs_scaley[:limit] || 1 , add: hs_scaley[:add] || 0 })
   o.st.alpha_hik  = ({  type:  hs_alpha[:type]   || :default , start:  hs_alpha[:start]  || 255 , limit:  hs_alpha[:limit]  || 0 , add: hs_alpha[:add]  || 0 })
   create_remilambda = lambda do | hs |
     self.count_select(hs[:type]).call   hs[:start] , hs[:limit] , hs[:add]
   end
   o.st.rotremi     =  create_remilambda[ o.st.rot_hik    ]
   o.st.scalexremi  =  create_remilambda[ o.st.scalex_hik ]
   o.st.scaleyremi  =  create_remilambda[ o.st.scaley_hik ]
   o.st.alpharemi   =  create_remilambda[ o.st.alpha_hik  ]


# --------------     --------------------------------------------------------------
#     dd = o.d.copy_new rescue nil
#     n = 0
#     ch = Yakumo_chen.count_true  o.d_p || 20
# Window.draw_Lumia の 定義を考える

# -------------------
   lambda do
      o.st.rot     = o.st.rotremi.call
      o.st.alpha   = o.st.alpharemi.call
      o.st.scalex  = o.st.scalexremi.call
      o.st.scaley  = o.st.scaleyremi.call
      Window.drawEx( o.x , o.y, o.d, ({ :angle => o.st.rot, :alpha => o.st.alpha,
           :scalex => o.st.scalex, :scaley => o.st.scaley , :z => o.st.fade_z }) )
   end

end
