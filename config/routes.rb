Rails.application.routes.draw do

  post "/login", to: "sessions#create" 

  post "/signup", to: "users#create" 

  get "/self", to: "users#show" 

  delete "/logout", to: "sessions#destroy" 

  scope '/api' do 
    get '/channels/:name', to: 'channels#show_by_name'

    concern :messagable do
      resources :messages
    end
    
    resources :users, concerns: :messagable
    resources :channels, concerns: :messagable

    resources :messages


  end

  get "*path", to: "fallback#index", constraints: ->(req) { !req.xhr? && req.format.html? }

end
