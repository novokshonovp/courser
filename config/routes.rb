Rails.application.routes.draw do
  root to: 'courser#course', :as => :courser_course
  get  '/admin', to: 'courser#admin', as: :courser_admin
  post '/create', to: 'courser#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
