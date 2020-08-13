JoobqGui.pipelines do
  build :web do
    plug Azu::Rescuer.new
    plug Azu::Logger.new
  end

  build :static do
    plug StaticHandler.new "public", true
  end
end
