require "sinatra/activerecord"

class Message < ActiveRecord::Base
  validates :message, :link, presence: true
end
