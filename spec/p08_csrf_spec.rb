require 'webrick'
require 'phase6/controller_base'
require 'phase6/router'
require 'byebug'

describe "the symphony of things" do
  let(:req) { WEBrick::HTTPRequest.new(Logger: nil) }
  let(:res) { WEBrick::HTTPResponse.new(HTTPVersion: '1.0') }

  before(:all) do
    class Ctrlr < Phase6::ControllerBase
      def route_render
        render_content("testing", "text/html")
      end

      def route_does_params
        render_content("got ##{ params["id"] } and form_authenticity_token: #{ form_authenticity_token }", "text/text")
        puts csrf.inspect
      end

      def update_session
        session[:token] = "testing"
        render_content("hi", "text/html")
      end
    end
  end
  after(:all) { Object.send(:remove_const, "Ctrlr") }

  describe "routes and params" do
    it "route instantiates controller and calls invoke action" do
      route = Phase6::Route.new(Regexp.new("^/statuses/(?<id>\\d+)$"), :get, Ctrlr, :route_render)
      allow(req).to receive(:path) { "/statuses/1" }
      allow(req).to receive(:request_method) { :get }
      route.run(req, res)
      expect(res.body).to eq("testing")
    end

    it "route adds to params" do
      route = Phase6::Route.new(Regexp.new("^/statuses/(?<id>\\d+)$"), :post, Ctrlr, :route_does_params)
      allow(req).to receive(:path) { "/statuses/1" }
      allow(req).to receive(:request_method) { :post }
      route.run(req, res)
      expect(res.body).to eq("got #1")
    end
  end
end
