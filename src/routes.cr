JoobqGui.router do
  root :web, Dashboard::IndexEndpoint

  routes :web do
    get "/dashboard", Dashboard::IndexEndpoint
    get "/queues", Queues::IndexEndpoint
  end

  routes :static do
    get "/*", Static
  end
end
