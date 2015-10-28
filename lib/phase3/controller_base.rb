require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'active_support/inflector'
require 'erb'
require 'byebug'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      controller_name = ActiveSupport::Inflector.underscore(self.class)
      file_path = "views/#{controller_name}/#{template_name}.html.erb"
      data = read_template("views/#{controller_name}/#{template_name}.html.erb")
      erb = ERB.new(data).result(binding)
      render_content(erb, 'text/html')
    end

    def read_template(filename)
      file = File.open(filename, "r")
      data = file.read
      file.close
      data
    end
  end
end
