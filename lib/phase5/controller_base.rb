require_relative '../phase4/controller_base'
require_relative './params'

module Phase5
  class ControllerBase < Phase4::ControllerBase
    attr_reader :params

    # setup the controller
    def initialize(req, res, route_params = {})
      super(req, res)
      @params = Params.new(req, route_params)
    end
<<<<<<< HEAD

    def invoke_action(action_name)
      self.send(action_name)
    end
    
=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
  end
end
