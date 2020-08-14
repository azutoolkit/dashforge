JoobqGui.router do
  root :web, Dashboard::IndexEndpoint

  routes :web, "/dashboard" do
    get "/", Dashboard::IndexEndpoint
  end

  routes :web, "/queues"do
    get "/", Queues::IndexEndpoint
  end

  get "/busy", Queues::BusyEndpoint, :web
  get "/completed", Queues::BusyEndpoint, :web
  get "/failed", Queues::FailedEndpoint, :web
  get "/dead", Queues::DeadEndpoint, :web
  get "/jobs", Jobs::IndexEndpoint, :web

  routes :static do
    get "/*", Static
  end
end
