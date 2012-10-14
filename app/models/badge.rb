require 'imgkit'
require 'erb'
require root_path('config', 'imgkit.rb')

class Badge

  TEMPLATE_PATH = File.join(Main.settings.views, 'badge.html.erb')
  LEVEL_BOUNDARIES = 1.upto(100).with_index.map {|el, idx| el * idx * 50}

  attr_accessor :username, :xp

  def initialize(user, options={ })
    @user     = user
    @username = user.login
    @xp       = user.score || 0
    @options  = options
  end

  def level_percentage
    (xp - prev_level_boundary(xp)) / (next_level_boundary(xp) - prev_level_boundary(xp))
  end

  def get_level(xp)
    LEVEL_BOUNDARIES.each.with_index { |b, idx| xp > b or return idx }
  end

  def prev_level_boundary(xp)
    LEVEL_BOUNDARIES.each_cons(2) { |prev, curr| return prev if xp >= prev and xp < curr  }
  end

  def next_level_boundary(xp)
    LEVEL_BOUNDARIES.find { |exp_to_level| xp < exp_to_level }
  end

  def level
    get_level(@xp)
  end

  def get_template
    File.read(TEMPLATE_PATH)
  end

  def get_bindings
    binding
  end

  def apply_data_to_template
    template = ERB.new(get_template)
    template.result(get_bindings)
  end

  def render_to_string(type=:png)
    kit = IMGKit.new(apply_data_to_template)
    kit.to_img(type)
  end

  def render_to_file(file_path_with_extension)
    kit = IMGKit.new(apply_data_to_template)
    kit.to_file(file_path_with_extension)
  end

  def render(to_file=false, file_path=nil)
    return if to_file && !file_path
    to_file ? render_to_file(file_path) : render_to_string
  end

end
