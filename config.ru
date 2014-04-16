require ::File.expand_path('../config/environment',  __FILE__)
require './app.rb'

configure do
  set :root, File.dirname(__FILE__)
  set :views, File.join(Sinatra::Application.root, "views")

  yaml = YAML.load_file('./config.yaml')[settings.environment.to_s]
    yaml.each_pair do |key, value|
      set(key.to_sym, value)
    end
end

run Sinatra::Application