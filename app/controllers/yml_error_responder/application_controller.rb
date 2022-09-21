module YmlErrorResponder
  class ApplicationController < ActionController::Base
    handle_errors_with_yml_responder
  end
end
