Rails.application.routes.draw do
  get 'pricings/pricing'
  get 'daily_activities/index'
  get 'daily_activities/new'
  get 'daily_activities/create'
  get 'reports/index'
  get 'reports/show'
  get 'reports/create'
  get 'employees/index'
  root "sessions#login"

  get  "/signup", to: "users#signup"
  post "/signup", to: "users#create"
  get  "/login",  to: "sessions#login"
  post "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  get "/dashboard", to: "dashboard#index"
  get "employees", to: "employees#index", as: "employees"
  get "/resume", to: "resumes#show", as: :resume
  patch "/resume", to: "resumes#update"
  delete "/resume", to: "resumes#destroy"
  delete "/employee", to: "employees#destroy"
  #for reset password
  get  '/password/new',      to: 'reset_passwords#new_password',   as: 'new_password_reset'
  post '/password/create',   to: 'reset_passwords#create_password', as: 'create_password_reset'
  get  '/password/edit',     to: 'reset_passwords#edit_password',  as: 'edit_password_reset'
  patch '/password/update',  to: 'reset_passwords#update_password', as: 'update_password_reset'

  get "/pricing", to: "pricings#pricing", as: :pricing

  resources :employees
  resources :reports
  resources :demo_bookings, only:[:new, :create, :index]
  resources :daily_activities, only: [:index, :create, :new] do
    collection do
      get :export_csv
    end
  end
  
end
