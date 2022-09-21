module YmlErrorResponder
  class ErrorsController < ApplicationController
    def index
      @errors = YmlMapper.errors_handlers
    end
  end
end
