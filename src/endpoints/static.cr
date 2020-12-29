module JoobqGui
  class Static
    include HTTP::Handler

    def call(context : HTTP::Server::Context)
      Response::NotFound.new path: context.request.path
    end
  end
end
