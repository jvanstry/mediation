require 'rubygems'
require 'bundler'
Bundler.require
require './database.rb'

set :root, File.dirname(__FILE__)

get '/' do
  @title = 'index'
  erb :hello
end

get '/about' do

end

get '/rates' do

end

get '/contact' do

end

post '/contact' do

end