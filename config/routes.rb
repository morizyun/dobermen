Rails.application.routes.draw do
  root 'projects#index'

  resources :projects, except: %i(create destroy new show)
  resources :setting_gitlabs, except: %i(show)

  # Setting Page
  scope :setting, as: :setting do
    get '/', to: 'settings#show',   as: :show
    put '/', to: 'settings#update', as: :update
  end
end
