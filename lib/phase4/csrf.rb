require 'securerandom'

class Csrf


  CSRF_NAME = 'csrf'

  def initialize(req)
    @csrf_new = []
    cookie = req.cookies.find { |cookie| cookie.name == CSRF_NAME }
    @csrf_old = cookie ? JSON.parse(cookie.value) : []
  end

  def generate_token
    new_token = SecureRandom::urlsafe_base64
    @csrf_new << new_token
  end

  def includes?(token)
    @csrf_old.includes?(token)
  end

  def store_csrf(res)
    my_cookie = WEBrick::Cookie.new(CSRF_NAME, @csrf_new.to_json)
    res.cookies << my_cookie
  end

end

# 1. user goes to website first time
#   - check for csrf cookie
#   - no csrf cookie found
#   - generate csrf token based on SecureRandom
