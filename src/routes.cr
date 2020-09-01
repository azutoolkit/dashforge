JoobqGui.router do
  root :web, Dashboard::IndexEndpoint
  ws "/live-view", Azu::Spark
  ws "/charts-data", ChartsChannel

  routes :web, "/dashboard" do
    get "/", Dashboard::IndexEndpoint
  end

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
