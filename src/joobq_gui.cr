require "azu"
require "mime"
require "kilt"
require "kilt/slang"

require "./requests/**"
require "./responses/**"
require "./handlers/**"
require "./endpoints/**"
require "./configuration"
require "./pipelines"
require "./routes"

module JoobqGui
  include Azu
  VERSION = "0.1.0"
end
