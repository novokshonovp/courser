require 'sidekiq/web'


Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: 'courser#course', as: :root
  get  '/admin', to: 'courser#admin', as: :admin
  post '/create', to: 'courser#create'
  post '/refresh_rate', to: 'courser#refresh_rate', as: :refresh_rate
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
