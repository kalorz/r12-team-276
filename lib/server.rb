module Signature
  class Server < Sinatra::Base

    get '/' do
      "welcome"
    end
  end
end

