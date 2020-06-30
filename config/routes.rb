Rails.application.routes.draw do
  devise_for :users,controllers: { registrations:'users/registrations'}
  resources :patients,except: [:show]
  resources :meetings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'root#route'
  get 'footer' ,to: 'contact#footer'
end
