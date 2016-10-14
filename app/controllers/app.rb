require 'sinatra/base'

class SafeMessagingApp < Sinatra::Base
  set :haml, :format => :html5
  set :views, File.join(Dir.pwd, 'app', 'views')
  get '/' do
    haml :index
  end
end
