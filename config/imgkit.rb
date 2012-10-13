IMGKit.configure do |config|
  config.wkhtmltoimage = Rails.root.join('bin', 'wkhtmltoimage').to_s if ENV['RACK_ENV'] == 'production'
  config.default_options = { :quality => 60 }
  config.default_format  = :png
end