JoobqGui.router do
  root :web, Dashboard::IndexEndpoint

  routes :web, "/dashboard" do
    get "/", Dashboard::IndexEndpoint
  end

  routes :web, "/queues"do
    get "/", Queues::IndexEndpoint
  end

  get "/busy", Queues::BusyEndpoint, :web

  routes :static do
    get "/*", Static
  end
end
