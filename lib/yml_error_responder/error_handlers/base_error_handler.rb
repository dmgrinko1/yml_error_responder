module YmlErrorResponder
  module ErrorHandlers
    class BaseErrorHandler
      attr_accessor :handler_data, :error

      def initialize(error, handler_data)
        @handler_data = handler_data
        @error = error
      end

      def http_code
        @handler_data[:http_code]
      end

      def meta
        @error.try(:meta) || {}
      end

      def as_json
        {
          data: {
            error: {
              code: @handler_data[:error_code],
              description: @handler_data[:description]
            },
            meta: meta
          }
        }
      end
    end
  end
end
