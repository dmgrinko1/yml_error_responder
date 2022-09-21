Rails.application.routes.draw do

  mount YmlErrorResponder::Engine => "/yml_error_responder"
end
