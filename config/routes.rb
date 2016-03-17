Rails.application.routes.draw do
  root 'projects#index'
  resources :projects, except: [:create, :destroy, :new, :show]

  # Setting Page
  scope :setting, as: :setting do
    get '/', to: 'settings#show', as: :show
    put '/', to: 'settings#update', as: :update
  end
end
