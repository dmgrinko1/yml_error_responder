module YmlErrorResponder
  module ErrorHandlers
    class UnknowErrorHandler < BaseErrorHandler
      def initialize
        @handler_data = {
          http_code: :internal_server_error,
          error_code: :unknow_error,
          description: 'Something went wrong.'
        }
      end
    end
  end
end
