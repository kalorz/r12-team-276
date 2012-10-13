require 'imgkit'
require 'erb'

class Badge

  TEMPLATE_PATH = "views/badge.html.erb"

  attr_accessor :username, :xp

  def initialize(user, options={ })
    @user     = user
    @username = user.username
    @xp       = user.xp || 0
    @options  = options
  end

  def level_percentage
    @user.level_percentage
  end

  def level
    @user.level
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