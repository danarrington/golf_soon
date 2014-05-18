GolfSoon::Application.routes.draw do
  root :to => "home#index"
  devise_for :users, :controllers => {:registrations => "registrations"}
  resources :users

  get '/pick_courses' => 'home#pick_courses', :as => :pick_courses
  post '/pick_courses' => 'home#pick_courses_submit'
  get '/times' => 'tee_time#times', :as => :times
end