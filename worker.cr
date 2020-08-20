require "joobq"
require "./src/jobs/**"
require "./src/config/**"
require "colorize"

def Process.rss
  `ps -o rss= -p #{Process.pid}`.chomp.to_i
end

JoobQ.forge 

sleep