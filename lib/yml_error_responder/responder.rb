module YmlErrorResponder
  module Responder
    extend ActiveSupport::Concern

    included do
      rescue_from Exception, with: :resque_global
    end

    private

    def resque_global(error)
      if YmlMapper.error_defined?(error)
        respond_with_error ErrorHandlers::handler(error, YmlMapper.error_payload(error))
      else

        log_error(error)
        ExceptionNotifier.notify_exception(error) if defined?(ExceptionNotifier)

        if YmlErrorResponder.handle_unknown_error
          respond_with_error ErrorHandlers.unknown_error
        else
          raise error
        end
      end
    end

    def respond_with_error(handler)
      respond_to do |format|
        format.html do
          render file: "#{Rails.root}/public/#{handler.http_code}",
            layout: false,
            status: handler.http_code
        end
        format.json do
          render json: handler.as_json,
            status: handler.http_code
        end
      end
    end

    def log_error(error)
      if YmlErrorResponder.unknown_error_logger.respond_to?(:call)
        YmlErrorResponder.unknown_error_logger.call(error)
      end
      Rails.logger.error error.message
      Rails.logger.error error.backtrace.join("\n")
    end
  end
end

class << ActionController::Base
  def handle_errors_with_yml_responder
    include YmlErrorResponder::Responder
  end
end
