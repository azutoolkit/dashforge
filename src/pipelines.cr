JoobqGui.pipelines do
  build :web do
    plug Azu::Rescuer.new
    plug Azu::Logger.new
  end

  build :static do
    plug Azu::Static.new "public"
  end
end
