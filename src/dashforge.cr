require "azu"
require "./config/**"

module DashForge
  include Azu
  VERSION = "0.1.0"
  JoobQ::Statistics.create_series

  configure do |c|
    c.templates.path = "public/templates"
    c.router.ws "/spark", Spark
    c.router.get "/*", Handler::Static.new
  end
end

require "./components/**"
require "./jobs/**"
require "./pages/**"
require "./endpoints/**"
require "./channels/**"

DashForge.start [
  DashForge::Handler::Rescuer.new,
  DashForge::Handler::Logger.new,
]
