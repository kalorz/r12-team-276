module Signature
  class Server < Sinatra::Base
    register Sinatra::ConfigFile
    register Sinatra::RespondWith

    config_file '../config/settings.yml'

    get '/' do
      :ok
    end

    get '/_users'  do
      Signature::User.all.to_json
    end

    get '/:login/?:style?.png' do
    end

  end
end

