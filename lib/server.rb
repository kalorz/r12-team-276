module Signature
  class Server < Sinatra::Base
    register Sinatra::ConfigFile

    config_file '../config/settings.yml'

    get '/' do
      "#{settings.github['client_id']}"
    end

    get '/:login/?:style?.png' do
    end

  end
end

