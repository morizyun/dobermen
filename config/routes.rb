Rails.application.routes.draw do
  root 'projects#index'
  resources :projects, except: [:create, :destroy, :new, :show]
end
