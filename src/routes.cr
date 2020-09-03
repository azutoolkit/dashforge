JoobqGui.router do
  root :web, Dashboard::Index

  ws "/live-view", Azu::Spark
  ws "/charts-data", ChartsChannel

  routes :web, "/queues" do
    get "/:name", Queues::Show
  end

  routes :web, "/jobs" do
    get "/", Jobs::Show
  end

  routes :static do
    get "/*", Static
  end
end
