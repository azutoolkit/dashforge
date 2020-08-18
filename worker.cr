require "joobq"
require "./src/jobs/**"
require "./src/config/**"
require "colorize"

spawn do
  loop do
    JoobQ.forge
  end
end

sleep