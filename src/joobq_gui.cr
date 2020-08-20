require "azu"
require "mime"
require "joobq"

require "./jobs/*"
require "./config/**"
require "./channels/**"
require "./sparks/**"
require "./views/**"
require "./handlers/**"
require "./endpoints/**"
require "./services/**"
require "./configuration"
require "./pipelines"
require "./routes"

module JoobqGui
  include Azu
  VERSION = "0.1.0"
end
