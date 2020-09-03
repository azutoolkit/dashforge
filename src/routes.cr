JoobqGui.router do
  root :web, Dashboard::Index
  ws "/live-view", Azu::Spark
  ws "/charts-data", ChartsChannel

  routes :web, "/queues" do
    get "/:name", Queues::IndexEndpoint
  end

  routes :web, "/jobs" do
    get "/", Jobs::ShowEndpoint
  end

  routes :static do
    get "/*", Static
  end
end
