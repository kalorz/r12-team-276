class Main

  get '/' do
    slim :index
  end

  get '/_users'  do
    User.all.to_json
  end

  get '/:login/?:style?.png' do
    user = User.new
    user.login = 'ksarnacki'
    user.score = 1000
    badge = Badge.new(user)
    badge.render(true, "public/img/badges/#{user.login}.png")
    @login = user.login
    slim :badge_display
  end

end
