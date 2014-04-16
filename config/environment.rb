ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

require 'rubygems'

require 'uri'
require 'pathname'
require 'mongo'
require 'json/ext'

require 'pony'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'


# Some helper constants for path-centric logic
APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s

require APP_ROOT.join('config', 'database')

Dir[APP_ROOT.join('helpers', '*.rb')].each { |file| require file }