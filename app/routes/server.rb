class Main

  get '/' do
    slim :index
  end

  get '/_users'  do
    User.all.to_json
  end

  get '/:login/?:style?.png' do
  end

end
