require 'sinatra/base'
require_relative '../models/message.rb'
class SafeMessagingApp < Sinatra::Base
  set :haml, :format => :html5
  set :views, File.join(Dir.pwd, 'app', 'views')
  set :public_folder, Proc.new { File.join(Dir.pwd, "public") }
  get '/' do
    haml :index, locals: { root: settings.root }
  end

  post '/' do
    flash = { message: "ok" }
    haml :index, locals: flash
  end
end
