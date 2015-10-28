require 'json'
require 'webrick'

module Phase4
  class Session

    APP_NAME = '_rails_lite_app'
    attr_reader :session
    # find the cookie for this app
    # deserialize the cookie into a hash
    def initialize(req)
      cookie = extract_cookie(req.cookies)
      if cookie
        @session = JSON.parse(cookie.value)
      end
      @session ||= {}
    end

    def [](key)
      session[key]
    end

    def []=(key, val)
      session[key] = val
    end

    def extract_cookie(cookies)
      cookies.find { |el| el.name == APP_NAME }
    end

    # serialize the hash into json and save in a cookie
    # add to the responses cookies
    def store_session(res)
      my_cookie = WEBrick::Cookie.new(APP_NAME, @session.to_json)
      res.cookies << my_cookie
    end
  end
end
