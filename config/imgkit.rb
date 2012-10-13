IMGKit.configure do |config|
  config.wkhtmltoimage = File.expand_path File.dirname(__FILE__) + '/bin/wkhtmltoimage'  if ENV['RACK_ENV'] == 'production'
  config.default_options = { :quality => 60 }
  config.default_format  = :png
end