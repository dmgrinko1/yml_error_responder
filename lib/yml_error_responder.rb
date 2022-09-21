require 'yml_error_responder/yml_mapper'
require 'yml_error_responder/error_handlers'
require 'yml_error_responder/error_handlers/base_error_handler'
require 'yml_error_responder/error_handlers/default_error_handler'
require 'yml_error_responder/error_handlers/unknow_error_handler'
require 'yml_error_responder/responder'
require 'yml_error_responder/engine'

module YmlErrorResponder
  @configuration_path = 'config/errors/'
  @handle_unknown_error = false
  @unknown_error_logger = nil

  class << self
    attr_accessor :configuration_path
    attr_accessor :handle_unknown_error
    attr_accessor :unknown_error_logger

    def setup
      yield self
    end

    def log_unknown_error_with(&block)
      @unknown_error_logger = block
    end

    def routes(application)
      unless Rails.env.production?
        application.mount YmlErrorResponder::Engine => "/api/yml_error_responder"
      end
    end
  end
end
