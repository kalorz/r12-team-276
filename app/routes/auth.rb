class Main

  get '/_/auth/callback' do
    omniauth = env['omniauth.auth']

    user = User.find_or_create_by(uid: omniauth['uid'])
    user.update_attributes(
        login:      omniauth['info']['nickname'],
        github_url: omniauth['info']['urls']['GitHub'],
        avatar_url: omniauth['info']['image']
    )

    session[:user_id] = user.id

    redirect '/'
  end

end
