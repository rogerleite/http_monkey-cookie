module HttpMonkey::Middlewares

  class Cookie

    def initialize(app, options = {})
      @app = app
      #FIXME: http_monkey v0.0.3, change store to env.storage
      @store = options.fetch(:store, HttpMonkey::Cookie::MemoryStore.instance)
      @debug = options.fetch(:debug, false)
    end

    def call(env)
      log "-> Cookie Middleware"

      retrieve_cookie(env)
      response = @app.call(env)
      store_cookie(env, response)

      log "<- Cookie Middleware"
      response
    end

    protected

    # Chech for cookies stored to domain
    def retrieve_cookie(env)
      cookiejar = @store.read("cookiejar")
      return if cookiejar.nil?

      url = env.uri.to_s
      cookies = cookiejar.get_cookie_header(url)
      log "--> Cookies(#{url}): #{cookies.inspect}"
      env["HTTP_COOKIE"] = cookies
    end

    def store_cookie(env, response)
      headers = response[1]
      set_cookie = headers["Set-Cookie"]
      return if set_cookie.nil?

      cookiejar = @store.read("cookiejar")
      cookiejar = ::CookieJar::Jar.new unless cookiejar
      url = env.uri.to_s
      if cookiejar.get_cookies(url).empty?
        Array(set_cookie).each do |header_cookie|
          cookiejar.set_cookie(url, header_cookie)
        end
        @store.write("cookiejar", cookiejar)
        log "<-- Store: #{@store.inspect}"
      end
      nil
    end

    def log(msg)
      puts msg if @debug
    end
  end

end
