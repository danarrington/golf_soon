GolfSoon::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  get '/pick_courses' => 'home#pick_courses', :as => :pick_courses
  post '/pick_courses' => 'home#pick_courses_submit'
  match '/times' => 'tee_time#times', :as => :times, via: [:get, :post]
  match '/update_data' => 'tee_time#update', :as => :update, via: [:get, :post]
  match '/noop' => 'tee_time#noop', :as => :noop, via: [:get, :post]
end