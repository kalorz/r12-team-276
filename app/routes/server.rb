class Main

  get '/' do
    :ok
  end

  get '/_users'  do
    User.all.to_json
  end

  get '/:login/?:style?.png' do
  end

end
