require File.expand_path '../spec_helper.rb', __FILE__

def create_message
  Message.create message: "some text here", link: Digest::MD5.hexdigest(Time.new.to_i.to_s), destruction_delay: 0
end

describe "My Sinatra Application" do
  it "should allow accessing the home page" do
    get '/'
    expect(last_response.status).to eq(200)
  end
  it "should not allow empty message" do
    post '/'
    expect(last_response.status).to eq(204)
  end
  it "should create message" do
    last_count = Message.count
    post '/', message: "some message"
    expect(last_count + 1).to eq(Message.count)
  end
  it "sould show a message" do
    message = create_message
    get "/message/#{message.link}"
    expect(last_response).to be_ok
  end
  it "sould delete a message after visit" do
    message = create_message
    get "/message/#{message.link}"
    next_try_message = nil
    begin
      next_try_message = Message.find(message.id)
      expect(next_try_message.nil?).to eq(true)
    rescue ActiveRecord::RecordNotFound => r
      expect(true).to eq(true)
    end
  end
end
