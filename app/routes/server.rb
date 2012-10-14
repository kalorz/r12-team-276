class Main

  # Get login from URL or parameter (/?login=xxx)
  get '/:login?' do
    return slim(:index, layout: !request.xhr?) unless params[:login]

    if params[:login].index('.')
      @login, _, @format = params[:login].rpartition('.')
    else
      @login = params[:login]
    end

    @current_user = User.find_or_create_by(login: @login)

    if @format == 'png'
      user       = User.new
      user.login = 'ksarnacki'
      user.score = 1000
      badge      = Badge.new(user)
      file_name  = "public/img/badges/#{user.login}.png"
      badge.render(true, file_name)
      send_file(file_name, disposition: 'inline', type: 'image/png', filename: File.basename(file_name))
    else
      slim :index, layout: !request.xhr?
    end
  end

end
