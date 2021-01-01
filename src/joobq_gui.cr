require "azu"
require "joobq"

module JoobqGui
  include Azu
  VERSION = "0.1.0"

  JoobQ::Statistics.create_series

  configure do
    templates.path = "src/templates"
  end

  Pipeline[:web] = [
    Handler::Rescuer.new,
    Handler::Logger.new,
    Handler::Static.new("public"),
  ]

  Pipeline[:static] = [
    Handler::Static.new("public"),
  ]

  router do
    root :web, Dashboard::Index

    ws "/live-view", Spark
    ws "/charts-data", ChartsChannel

    routes :web, "/queues" do
      get "/:queue", Queues::Show
      get "/traces/:name", Queues::Traces
      get "/:queue/jobs/:job_id", Jobs::Show
    end

    

    routes :static do
      get "/*", Static
    end
  end
end

require "./jobs/*"
require "./config/**"
require "./pages/**"
require "./endpoints/**"
require "./channels/**"
require "./components/**"
