require 'zlib'
Dir.chdir File.dirname(File.expand_path(__FILE__))

BMPFILEHEADER = Struct.new(:type, :size, :reserve1, :reserve2, :offset)
BITMAPINFOHEADER = Struct.new(:size, :width, :height, :planes, :bitcount, :compression, :sizeimage, :Xpixpm, :Ypixpm, :paletteUsed, :paletteImportant)

def open_bmp(fn)
  bmp = nil
	open(fn,"rb:ASCII-8BIT"){|f|
    bmp = f.read
  }

	dat = bmp[0..13].unpack("a2L<S<S<L<")
	bfh = BMPFILEHEADER.new
	bfh.type = dat[0]
	bfh.size = dat[1]
	bfh.reserve1 = dat[2]
	bfh.reserve2 = dat[3]
	bfh.offset = dat[4]

	dat = bmp[14..17].unpack("L<")
	bih = BITMAPINFOHEADER.new
	bih.size = dat[0]
	if bih.size<40 then
		raise "未対応フォーマット(#{bih.inspect})"
	end
	dat = bmp[18..53].unpack("l<l<S<S<L<L<l<l<L<L<")
	bih.width = dat[0]
	bih.height = dat[1]
	bih.planes = dat[2]
	bih.bitcount = dat[3]
	bih.compression = dat[4]
	bih.sizeimage = dat[5]
	bih.Xpixpm = dat[6]
	bih.Ypixpm = dat[7]
	bih.paletteUsed = dat[8]
	bih.paletteImportant = dat[9]
	if bih.compression != 0 or bih.bitcount != 24 or bih.height<1 or bih.width<1 then
		raise "未対応フォーマット(#{bih.inspect})"
	end
	#p bfh,bih

	y=bih.height-1
	pos = 0
	image=[]
	while y>=0
		line = bmp[bfh.offset + pos,3*bih.width]
		pos += 3*bih.width
		pos = pos+3 & 0xFFFFFFFFFFFFFFFC
		image[y]=line
		y-=1
	end

	return [bfh, bih, image]
end

CHUNK = Struct.new(:size, :type, :body, :crc, :crc_chekc)
IHDR  = Struct.new(:width, :height, :depth, :color, :compress, :filter, :interlace)

def bmp_to_png(bmp)

  my_PNGSIG = "\x89\x50\x4E\x47\x0D\x0A\x1A\x0A".force_encoding("ASCII-8BIT")
	res = [my_PNGSIG]

	ihdr = IHDR.new
	ihdr.width = bmp[1].width
	ihdr.height = bmp[1].height
	ihdr.depth = 8
	ihdr.color = 6
	ihdr.compress = 0
	ihdr.filter = 0
	ihdr.interlace = 0

	hdr = CHUNK.new
	hdr.size = 13
	hdr.type = "IHDR"
	hdr.body = ihdr
	res << hdr

	iend = CHUNK.new
	iend.size = 0
	iend.type = "IEND"
	iend.body = ""
	res << iend

	bmpi = bmp[2]
	pngi = []

	a255 = "\xFF".force_encoding("ASCII-8BIT")
	l255 = a255*(4*ihdr.width)
	for line in bmpi do
		pos = 0
		posp = 0
		pngl = l255.clone
		while pos<line.size
			# BGR => RGBA
			pngl[posp,3] = line[pos,3].reverse
			pos += 3
			posp += 4
		end
		pngi << [0, pngl]
	end
	res << pngi
end

def make_chunk(head, body)
	[body.size].pack("L>") << head << body << [Zlib::crc32(head+body)].pack("L>")
end

def png_to_binary(png)
	res = png[0]
	ihdr = png[1].body
	ihdr = [ihdr.width, ihdr.height, ihdr.depth, ihdr.color, ihdr.compress, ihdr.filter, ihdr.interlace].pack("L>L>CCCCC")
	res << make_chunk("IHDR", ihdr)
	image = png[-1]

	pngi = ""
	for line in image do
		pngi << line.pack("Ca*")
	end
	res << make_chunk("IDAT", Zlib::Deflate.deflate(pngi, 9)) << make_chunk("IEND", "")
end

def read_bmp_write_png(bmpin, pngout)
		bmp = open_bmp(bmpin)
		png = bmp_to_png(bmp)
		png = png_to_binary(png)
		open(pngout, "wb:ASCII-8BIT"){|f|
			f.write png
		}
end



Dir.glob("*.bmp"){|f|
	inf = f
	from = File.stat(inf).size
	outf = f.gsub(/\.bmp$/i,".png")
	STDOUT.print "#{inf} => #{outf}"
		start = Time.now
		read_bmp_write_png(inf, outf)
		finish = Time.now
		to = File.stat(outf).size
		text = sprintf("  (%6.3f sec.) [%d > %d : %7.3f%%]", finish.to_f-start.to_f, from, to, ( to.to_f / [from,1].max ) *100 )
	STDOUT.puts text
}
