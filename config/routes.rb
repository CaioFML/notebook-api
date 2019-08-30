Rails.application.routes.draw do
  resources :auths, only: %i[create]

  resources :kinds
  resources :contacts do
    resource :kind, only: %i[show]
    resource :kind, only: %i[show], path: 'relationships/kind'

    resource :phones, only: %i[show]
    resource :phones, only: %i[show], path: 'relationships/phones'

    resource :phone, only: %i[update create destroy]
    resource :phone, only: %i[update create destroy], path: 'relationships/phones'

    resource :address, only: %i[show update create destroy]
    resource :address, only: %i[show update create destroy], path: 'relationships/address'
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
