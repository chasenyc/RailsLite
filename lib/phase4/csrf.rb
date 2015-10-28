class CSRF

  CSRF_NAME = 'csrf'

  def initialize(req)
    cookie = req.cookies.find { |cookie| cookie.name == APP_NAME }
    @csrf = cookie ? JSON.parse(cookie.value) : {}
  end

  def is_token?(token)
    BCrypt::Password.new(@csrf).is_password?(token)
  end

  def store_csrf
    my_cookie = WEBrick::Cookie.new(CSRF_NAME, @csrf.to_json)
    res.cookies << my_cookie
  end
end
