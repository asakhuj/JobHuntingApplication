Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/users/sign_in' => 'users#sign_in'
  post '/users/check_credentials' => 'users#check_credentials'
  get '/homepage' => 'users#homepage'
  get '/users/logout' => 'users#logout'
  get '/real_estate_companies/new' => 'real_estate_companies#new'
  get '/real_estate_companies' => 'real_estate_companies#index'
  post '/real_estate_companies/create' => 'real_estate_companies#create'
  root 'users#sign_in'
  get '/realtors/new' => 'realtors#new'
  post '/realtors/create' => 'realtors#create'
  get '/realtors/edit_company' => 'realtors#edit_company'
  post '/realtors/save_company' => 'realtors#save_company'
  get '/house_hunters/new' => 'house_hunters#new'
  post '/house_hunters/create' => 'house_hunters#create'
  get '/houses/new' => 'houses#new'
  post '/houses/create' => 'houses#create'
  get '/houses/index' => 'houses#index'
  get '/users/show_all' => 'users#show_all'
  get '/realtors' => 'realtors#index'
  get '/add_to_interest_list/:id' => 'houses#add_to_interest_list'
  get '/show_houses_with_filters/' => 'houses#show_houses_with_filters'
  get '/inquiries/new/:id' => 'inquiries#new'
  post '/inquiries/create' => 'inquiries#create'
  get '/inquiries/current_user_inquiries' => 'inquiries#current_user_inquiries'
  get 'houses/houses_posted_by_me' => 'houses#houses_posted_by_me'
  get 'houses/houses_posted_by_company' => 'houses#houses_posted_by_company'
  get '/show_potential_buyers/:id' => 'houses#show_potential_buyers'
  get '/inquiries/show_all_for_company' => 'inquiries#show_all_for_company'
  get '/inquiries/new_reply/:id' => 'inquiries#new_reply'
  post '/inquiries/create_reply/:id' => 'inquiries#create_reply'
  get '/users/reset_password_form' => 'users#reset_password_form'
  post '/users/reset_password' => 'users#reset_password'
  get '/houses/add_image_to_house/:id' => 'houses#add_image_to_house'
  post '/houses/upload_image/:id' => 'houses#upload_image'
  get '/houses/my_interest_list' => 'houses#my_interest_list'
  get '/houses/remove_from_interest_list/:id' => 'houses#remove_from_interest_list'
  resources :inquiries
  resources :admins
  resources :realtors
  resources :real_estate_companies
  resources :houses
end
