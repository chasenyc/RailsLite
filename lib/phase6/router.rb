<<<<<<< HEAD
require 'byebug'

=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
module Phase6
  class Route
    attr_reader :pattern, :http_method, :controller_class, :action_name

    def initialize(pattern, http_method, controller_class, action_name)
      @pattern, @http_method = pattern, http_method
      @controller_class, @action_name = controller_class, action_name
    end

    # checks if pattern matches path and method matches request method
    def matches?(req)
<<<<<<< HEAD
      !(pattern =~ req.path).nil? && http_method.to_s == req.request_method.to_s.downcase
=======
      pattern =~ req.path
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end

    # use pattern to pull out route params (save for later?)
    # instantiate controller and call controller action
    def run(req, res)
<<<<<<< HEAD
      params = pattern.match(req.path)
      route_p = {}
      params.names.each do |name|
        route_p[name] = params[name]
      end
      res.status = 404 unless matches?(req)
      instance_class = controller_class.new(req,res, route_p)
      instance_class.invoke_action(action_name)
=======
      debugger
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end
  end

  class Router
    attr_reader :routes

    def initialize
<<<<<<< HEAD
      @routes = []
=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end

    # simply adds a new route to the list of routes
    def add_route(pattern, method, controller_class, action_name)
<<<<<<< HEAD
      routes << Route.new(pattern, method, controller_class, action_name)
=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end

    # evaluate the proc in the context of the instance
    # for syntactic sugar :)
    def draw(&proc)
<<<<<<< HEAD
      instance_eval(&proc)
=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end

    # make each of these methods that
    # when called add route
    [:get, :post, :put, :delete].each do |http_method|
<<<<<<< HEAD
      define_method(http_method) do |pattern, controller_class, action_name|
        add_route(pattern, http_method, controller_class, action_name)
      end
=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end

    # should return the route that matches this request
    def match(req)
<<<<<<< HEAD
      routes.each do |route|
        return route if !(route.pattern =~ req.path).nil?
      end

      nil
=======
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
    end

    # either throw 404 or call run on a matched route
    def run(req, res)
<<<<<<< HEAD
      route = match(req)
      puts "RUNNING."
      if route
        puts "LALALA #{route}"
        route.run
      else
        res.status = 404
      end
    end

=======
    end
>>>>>>> 4b92f6bfdf2e070f5d99d8a734f1783cb73cbe0e
  end
end
