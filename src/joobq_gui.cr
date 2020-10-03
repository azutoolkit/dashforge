require "azu"
require "joobq"

require "./jobs/*"
require "./config/**"
require "./channels/**"
require "./components/**"
require "./pages/**"
require "./handlers/**"
require "./endpoints/**"
require "./configuration"
require "./pipelines"
require "./routes"

module JoobqGui
  include Azu
  VERSION = "0.1.0"
end
