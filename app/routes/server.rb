class Main


  # Get login from URL or parameter (/?login=xxx)
  get '/:login?' do
    return slim(:index, layout: !request.xhr?) unless params[:login] && !params[:login].blank?

    if params[:login].index('.')
      @login, _, @format = params[:login].rpartition('.')
    else
      @login = params[:login]
    end

    @current_user = User.get(@login)

    if image?(@format)
      send_badge_for(@current_user)
    else
      slim :index, layout: !request.xhr?
    end
  end

  private
  def image?(fmt)
    ["png"].include?(fmt)
  end

  def send_badge_for(user, format='png')
    file_name  = "public/img/badges/#{user.login}.#{format}"

    send_file(file_name,
              disposition: 'inline',
              type: 'image/png',
              filename: File.basename(file_name))
  end

end
