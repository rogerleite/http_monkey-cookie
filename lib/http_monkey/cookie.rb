require "cookiejar"

require "http_monkey/cookie/version"
require "http_monkey/middlewares/cookie"

module HttpMonkey

  module Cookie

    class MemoryStore

      def self.instance
        @@me ||= self.new
      end

      def initialize
        @store = Hash.new
      end

      def write(key, value)
        @store[key] = value
      end

      def read(key)
        @store[key]
      end

      def inspect
        @store.inspect
      end

    end

  end

end
