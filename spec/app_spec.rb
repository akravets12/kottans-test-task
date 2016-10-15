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
    
  end
end
