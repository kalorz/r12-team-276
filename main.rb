require './init'

class User
  attr_accessor :username, :xp

  def initialize(username, xp)
    @username = username
    @xp       = xp
  end

  def level_percentage
    70
  end

  def level
    5
  end
end

u = User.new('weszlem', 100)
b = Badge.new(u)
b.render(true, 'badge.min.png')