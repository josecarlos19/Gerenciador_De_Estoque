# frozen_string_literal: true
class ApiConstraints
  def initialize(options)
    @options = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    @default || req.headers['Accept']&.include?("application/vnd.app.v#{@version}")
  end
end
