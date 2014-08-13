require 'win32ole'

print "Insert wav file name: "
wavfile = gets.chomp
wavfile = File.expand_path(File.dirname(__FILE__))+'/'+wavfile

puts wavfile

player = WIN32OLE.new "WMPlayer.OCX"
player.openPlayer(wavfile)

puts player.ole_func_methods