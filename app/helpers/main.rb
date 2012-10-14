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

  end

end
