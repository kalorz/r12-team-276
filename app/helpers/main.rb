class Main

  helpers do

    def bagde_path(user)
      "/#{user.login}.png"
    end

    def badge_url(user)
      "#{full_host}#{bagde_path(user)}"
    end

    def full_host
      uri = URI.parse(request.url.gsub(/\?.*$/,''))
      uri.path = ''
      uri.query = nil
      #sometimes the url is actually showing http inside rails because the other layers (like nginx) have handled the ssl termination.
      uri.scheme = 'https' if(request.env['HTTP_X_FORWARDED_PROTO'] == 'https')
      uri.to_s
    end

    def badge_path_for(login, format='png')
      "img/badges/#{login}.#{format}"
    end

    ALPHA = [('a'..'z'), ('A'..'Z')].map(&:to_a).flatten

    def hr(length = 256)
      (0...length).map{ ALPHA[rand(ALPHA.length)] }.join
    end

  end

end
