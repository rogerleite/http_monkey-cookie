module HttpMonkey::Middlewares

  class Cookie

    def initialize(app)
      @app = app
    end

    def call(env)
      puts "-> Cookie before"
      response = @app.call(env)
      puts "-> Cookie after"
      response
    end

  end

end
