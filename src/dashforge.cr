require "azu"
require "joobq"

module DashForge
  include Azu
  VERSION = "0.1.0"
  JoobQ::Statistics.create_series
  
  configure do
    templates.path = "public/templates"

    router.ws "/live-view", Spark
    router.get "/*", Handler::Static

    pipelines = [
      Handler::Rescuer.new,
      Handler::Logger.new,
    ]
  end
end

require "./jobs/**"
require "./config/**"
require "./pages/**"
require "./endpoints/**"
require "./channels/**"
require "./components/**"
