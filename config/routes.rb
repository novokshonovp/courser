require 'sidekiq/web'


Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'
  root to: 'courser#course', :as => :courser_course
  get  '/admin', to: 'courser#admin', as: :courser_admin
  post '/create', to: 'courser#create'
  post '/refresh_rate', to: 'courser#refresh_rate', as: :refresh_rate
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
