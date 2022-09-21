YmlErrorResponder::Engine.routes.draw do
  get '/errors/list', to: 'errors#index'
end
