Rails.application.routes.draw do
  devise_for :users#,controllers: { registrations:'registrations'}
  resources :patients,except: [:show]
  resources :meetings
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'application#route'
  get 'footer' ,to: 'contact#footer'
end
