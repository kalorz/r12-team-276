class Main

  helpers do

    def current_user
      @current_user ||= session[:user_id] && User.find(session[:user_id])
    rescue
      session[:user_id] = nil
    end

    def partial(template, locals = {})
      slim(template, {layout: false}, locals)
    end

    def badge_path_for(login, format='png')
      "img/badges/#{login}.#{format}"
    end

  end

end
