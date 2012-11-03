Wuzup::Application.routes.draw do
  root :to => 'monitored_services#index'
  resources :users, controller: 'users', only: [:create, :new] do
    resource :password, controller: 'clearance/passwords', only: [:create, :edit, :update]
  end


  match 'sign_up' => 'users#new', :as => 'sign_up'
end
