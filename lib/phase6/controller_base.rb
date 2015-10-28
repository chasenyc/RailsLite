require_relative '../phase5/controller_base'

module Phase6
  class ControllerBase < Phase5::ControllerBase
    # use this with the router to call action_name (:index, :show, :create...)
    def invoke_action(name)
<<<<<<< HEAD
      self.send(name)
=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end
  end
end
