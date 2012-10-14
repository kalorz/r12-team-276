class Main

  get /\A\/([^.]+)?(\.png)?\z/ do |login, format|
    login  ||= params['login']
    format ||= params['format']

    @current_user = begin
      User.find_or_create_by(login: login)
    rescue
      raise Sinatra::NotFound
    end

    if format == '.png'
      user       = User.new
      user.login = 'ksarnacki'
      user.score = 1000
      badge      = Badge.new(user)
      badge.render(true, "public/img/badges/#{user.login}.png")
      @login = user.login
      slim :badge_display
    else
      slim :index, layout: !request.xhr?
    end
  end

end
