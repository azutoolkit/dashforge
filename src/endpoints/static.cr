class Static
  include HTTP::Handler

  def call(context : HTTP::Server::Context)
    raise Azu::NotFound.new path: context.request.path
  end
end
