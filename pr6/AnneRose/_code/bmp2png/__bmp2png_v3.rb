#coding:utf-8
require 'zlib'
Dir.chdir File.dirname(File.expand_path(__FILE__))

def open_bmp_to_png_to_binary(fn)
  bmp  = open(fn,"rb:ASCII-8BIT"){|f| f.read }
# ------- bmp header --------
  bmp_file_header = Struct.new(:type, :size, :reserve1, :reserve2, :offset).new \
    *bmp[0..13].unpack("a2L<S<S<L<")
  bmpih = Struct.new(:size, :width, :height, :planes, :bitcount, :compression, :sizeimage, :Xpixpm, :Ypixpm, :paletteUsed, :paletteImportant).new \
     bmp[14..17].unpack("L<")[0] , *bmp[18..53].unpack("l<l<S<S<L<L<l<l<L<L<")
  if (bmpih.size < 40) or (bmpih.compression != 0) or (bmpih.bitcount != 24) or (bmpih.height == 0) or (bmpih.width == 0)
  	raise "not saport format"	end
# ------- png_signechar IHDR + body + IEND  -------
	"\x89\x50\x4E\x47\x0D\x0A\x1A\x0A".b  \
     << make_chunk("IHDR", [bmpih.width, bmpih.height,8,6,0,0,0].pack("L>L>CCCCC") ) \
     << make_chunk("IDAT", Zlib::Deflate.deflate(
       (0...bmpih.height).map do
         line = bmp[ bmp_file_header.offset ,   bmpih.width*3]
                     bmp_file_header.offset += (bmpih.width*3 + 3) & 0xFFFFFFFFFFFFFFFC
         [0,line.chars.each_slice(3).inject(""){|s,(b,g,r)|s<<r+g+b+("\xFF".b)}].pack("Ca*")
   	   end.reverse.join , 9)) << make_chunk("IEND", "")
end

def make_chunk(head, body)
	[body.size].pack("L>") << head << body << [Zlib::crc32(head<<body)].pack("L>")
end

require "Benchmark" ; Benchmark.bm do|x|
  Dir.glob("*.bmp") do |fi|
  	o = fi.gsub(/\.bmp$/i,".png")
    x.report do
     png = open_bmp_to_png_to_binary fi
	   open( o , "wb:ASCII-8BIT"){|f| f.write png	}
		#  read_bmp_write_png(f, outf)
    end
  end
end
