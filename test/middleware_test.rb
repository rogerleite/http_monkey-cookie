require "test_helper"

COOKIE_MAGIC = "token=magic1"
SET_COOKIE_MAGIC = "#{COOKIE_MAGIC};Version=1;Comment=;Domain=.cookies.com;Path=/;Max-Age=999999999;httpOnly"

CookieApp = Rack::Builder.new do


  module Helper
    def self.respond_with(headers = {})
      [200, {"Content-Type" => "text/plain"}.merge(headers), ["body"]]
    end
  end

  map "/" do
    run lambda { |env|
      Helper.respond_with("Set-Cookie" => SET_COOKIE_MAGIC)
    }
  end

  map "/subhome" do
    run lambda { |env|
      Helper.respond_with("X-Request-Cookies" => env["HTTP_COOKIE"])
    }
  end
end

CookieMonkey = HttpMonkey.build do
  middlewares.use HttpMonkey::Middlewares::Cookie
end

describe HttpMonkey::Middlewares::Cookie do

  def self.before_suite
    @server = MinionServer.new(CookieApp).start("local.cookies.com", 1234)
  end

  def self.after_suite
    @server.shutdown
  end

  it "Magic cookie" do
    response = CookieMonkey.at("http://local.cookies.com:1234").get
    response.headers["Set-Cookie"].must_equal(SET_COOKIE_MAGIC)

    response = CookieMonkey.at("http://local.cookies.com:1234/subhome").get
    response.headers["X-Request-Cookies"].must_equal(COOKIE_MAGIC)
  end

end
