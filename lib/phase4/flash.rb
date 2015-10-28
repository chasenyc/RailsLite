class Flash

  attr_reader :flash

  def initialize(req)
    cookie = extract_cookie(req.cookies)
    if cookie
      @flash = JSON.parse(cookie.value)
    end
    @flash ||= {}
  end

  def extract_cookie(cookies)
    cookies.find { |el| el.name == APP_NAME }
  end

  def [](key)
    flash[key]
  end

  def []=(key, value)
    flash[key] = value
  end

  def serialize
    self.to_json
  end

end
