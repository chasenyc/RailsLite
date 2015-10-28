require 'json'
require 'webrick'

module Phase4
  class Session

    APP_NAME = '_rails_lite_app'
    attr_reader :session

    def initialize(req)
      cookie = req.cookies.find { |cookie| cookie.name == APP_NAME }
      @session = cookie ? JSON.parse(cookie.value) : {}
    end

    def [](key)
      session[key]
    end

    def []=(key, val)
      session[key] = val
    end

    def store_session(res)
      my_cookie = WEBrick::Cookie.new(APP_NAME, @session.to_json)
      res.cookies << my_cookie
    end
  end
end
