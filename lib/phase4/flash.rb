class Flash
  FLASH_NAME = 'flash'

	def initialize(req)
    @flash_send = {}
    cookie = req.cookies.find { |cookie| cookie.name == FLASH_NAME }
    @flash_display = cookie ? JSON.parse(cookie.value) : {}
  end

  def [](key)
    @flash_display[key]
  end

  def []=(key, val)
    @flash_send[key] = val
  end

  def now
    @flash_send
  end

  def store_flash(res)
    flash_cookie = WEBrick::Cookie.new(FLASH_NAME, @flash_send.to_json)
    flash_cookie.path = '/'
    res.cookies << flash_cookie
  end

end
