require "rubygems"
require "bundler"
require_relative "database.rb"
Bundler.require(:default)                   # load all the default gems
Bundler.require(Sinatra::Base.environment)  # load all the environment specific gems

$database = Database.getInstance
