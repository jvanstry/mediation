require './env' if File.exists?('env.rb')
require ::File.expand_path('../config/environment',  __FILE__)
require './app.rb'

configure do
  set :root, File.dirname(__FILE__)
  set :views, File.join(Sinatra::Application.root, "views")
end

run Sinatra::Application