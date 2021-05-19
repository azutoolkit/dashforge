require "azu"
require "joobq"
require "crometheus"

module DashForge
  include Azu
  VERSION = "0.1.0"
  JoobQ::Statistics.create_series
  Crometheus.default_registry.path = "/metrics"

  configure do |c|
    c.templates.path = "public/templates"
    c.router.ws "/live-view", Spark
    c.router.get "/*", Handler::Static.new
    c.router.get "/metrics", Crometheus.default_registry.get_handler
  end
end

require "./components/**"
require "./jobs/**"
require "./config/**"
require "./pages/**"
require "./endpoints/**"
require "./channels/**"

DashForge.start [
  Crometheus::Middleware::HttpCollector.new,
  Azu::Handler::Rescuer.new,
  Azu::Handler::Logger.new,
]
