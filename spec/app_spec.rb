require File.expand_path '../spec_helper.rb', __FILE__

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
    message = Message.create message: "some text here", link: Digest::MD5.hexdigest(Time.new.to_i.to_s)
    get "/message/#{message.link}"
    expect(last_response).to be_ok
  end
end
