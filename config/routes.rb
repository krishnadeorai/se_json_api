Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  jsonapi_resources :products

  root :to => redirect('/api/docs')

  get '/api/docs', to: 'apidocs#index'
  get '/simulate/*path', to: 'apidocs#simulate'
  get '/*path', to: 'apidocs#show'


end
