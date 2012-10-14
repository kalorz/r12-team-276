require 'imgkit'
require 'erb'
require root_path('config', 'imgkit.rb')

class Badge

  TEMPLATE_PATH = File.join(Main.settings.views, 'badge.html.erb')
  LEVEL_RANGES  = {
    1 => 0..100,
    2 => 100..10000,
    3 => 10000..1000000,
    4 => 1000000..10000000
  }

  attr_accessor :username, :xp

  def initialize(user, options={ })
    @user     = user
    @username = user.login
    @xp       = user.score || 0
    @options  = options
  end

  def level_percentage
    level           = get_level(xp)
    range           = LEVEL_RANGES[level]
    range_beginning = range.to_a.first
    xp / range_beginning
  end

  def get_level(xp)
    case xp
      when LEVEL_RANGES[1] then
        1
      when LEVEL_RANGES[2] then
        2
      when LEVEL_RANGES[3] then
        3
      when LEVEL_RANGES[4] then
        4
    end
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