require 'sinatra/base'
require_relative '../models/message.rb'
require "sinatra/activerecord"
require "digest/md5"
class SafeMessagingApp < Sinatra::Base
  set :haml, :format => :html5
  set :views, File.join(Dir.pwd, 'app', 'views')
  set :public_folder, Proc.new { File.join(Dir.pwd, "public") }
  register Sinatra::ActiveRecordExtension
  get '/' do
    haml :index, locals: { flash: nil, message: nil }
  end

  post '/' do
    message = Message.new message: params[:message],
                          link: Digest::MD5.hexdigest(Time.new.to_i.to_s),
                          destruction_delay: params[:destroy_delay]
    begin
      message.save!
      flash = { message: "ok" }
      status 201
    rescue ActiveRecord::RecordInvalid => invalid
      flash = { error: "error while creating message" }
      status 204
    end
    haml :index, locals: {flash: flash, message: message, host: request.host_with_port}
  end
  get '/message/:link' do
    @message = Message.find_by_link(params[:link])
    if !@message.nil?
      haml :show, locals: {message: @message.message}
    else
      redirect_to_404
    end
  end
  after '/message/:link' do
    @message.delete if(!@message.nil? && @message.destruction_delay == 0)
  end
  after '/', method: :post do
    Thread.new do
      if(@message.destruction_delay == 1)
        sleep 30.seconds
        @message.delete
      end
    end
  end

  def redirect_to_404
    redirect "http://#{request.host_with_port}/404.html"
  end

end
