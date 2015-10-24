require "net/ftp"

if ARGV.size != 3
  puts "0 --- id"
  puts "1 --- pass"
  puts "3 --- file"
  exit
end

# server = "ftp.geocities.jp"
server = "www42.atpages.jp"
id     = ARGV[0]
pass   = ARGV[1]
file   = ARGV[2]
up_file   = File.basename file

#rdir   = "./in/pr/release/"
rdir   = "./in/pr/backup/"


p id , pass , file , rdir

Net::FTP.open server do | ftp |
#  ftp.connect(  )
  ftp.login( id , pass )
  ftp.binary = true
  ftp.chdir( rdir )
  puts ftp.dir
  
  ftp.put( file , up_file )
#  ftp.put( local_file , up_file )

  # puts ftp.get( "index.html" , "test_get_file.txt")

end

# files = ftp.list("ruby*")
# ftp.getbinaryfile("ruby-1.9.1-p243.tar.bz2", "ruby.bz2", 1024)
