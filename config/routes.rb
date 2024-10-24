Rails.application.routes.draw do

  root 'teachers/dashboard#index'

  namespace :teachers do
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    get 'logout', to: 'sessions#destroy'

    post 'create', to: 'dashboard#create'
    get 'create', to: 'dashboard#edit', as: "edit_user"
    post 'update', to: 'dashboard#update'
    get 'destroy', to: 'dashboard#destroy'

  end

end
