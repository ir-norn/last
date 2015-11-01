  ["./index.rb"].cycle.inject File.dirname( $0 ) do | dir , file |
    Dir.chdir dir
    break(require file) if File.exist? file
    if dir.size < 4 then (p"require_err #{$0}") ; exit end
    File.dirname( dir )
  end
