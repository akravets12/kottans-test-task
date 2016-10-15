require 'sinatra/base'
require_relative '../models/message.rb'
require "sinatra/activerecord"
class SafeMessagingApp < Sinatra::Base
  set :haml, :format => :html5
  set :views, File.join(Dir.pwd, 'app', 'views')
  set :public_folder, Proc.new { File.join(Dir.pwd, "public") }
  register Sinatra::ActiveRecordExtension
  get '/' do
    haml :index, locals: { root: settings.root }
  end

  post '/' do
    begin
      message = Message.new message: params[:message]
      message.save!
      flash = { message: "ok" }
      status 201
    rescue ActiveRecord::RecordInvalid => invalid
      flash = { error: "error while creating message" }
      status 204
    end
    haml :index, locals: {flash: flash}
  end

end
