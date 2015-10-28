require_relative '../phase3/controller_base'
require_relative './session'
require_relative './flash'
require_relative './csrf'

module Phase4
  class ControllerBase < Phase3::ControllerBase
    def redirect_to(url)
      super(url)
      store_session_and_flash
    end

    def render_content(content, content_type)
      super(content, content_type)
      store_session_and_flash
    end

    def form_authenticity_token
      csrf.generate_token
    end

    # method exposing a `Session` object
    def session
      @session ||= Session.new(req)
    end

    def flash
      @flash ||= Flash.new(req)
    end

    def csrf
      @csrf ||= Csrf.new(req)
    end

    def store_session_and_flash
      session.store_session(res)
      flash.store_flash(res)
      csrf.store_csrf(res)
    end
  end
end
