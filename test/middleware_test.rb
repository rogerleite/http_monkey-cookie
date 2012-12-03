require "test_helper"

CookieApp = Rack::Builder.new do
  map "/" do
    run lambda { |env|
      [200, {"Content-Type" => "text/plain"}, ["body"]]
    }
  end
end

describe HttpMonkey::Middlewares::Cookie do

  def self.before_suite
    @server = MinionServer.new(CookieApp).start
  end

  def self.after_suite
    @server.shutdown
  end

  it "bah" do
    response = HttpMonkey.at("http://localhost:4000").get
    response.body.must_equal("body")
  end

end
