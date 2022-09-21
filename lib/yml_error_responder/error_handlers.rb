module YmlErrorResponder
  module ErrorHandlers
    extend self

    def unknown_error
      UnknowErrorHandler.new
    end

    def handler(error, payload)
      lookup_handler(error).new(error, payload)
    end

    private

    def lookup_handler(error)
      "::ErrorHandlers::#{error.class.to_s}".constantize
    rescue
      DefaultErrorHandler
    end
  end
end
