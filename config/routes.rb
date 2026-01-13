Rails.application.routes.draw do
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
  resources :employees
  resources :reports
  resources :demo_bookings, only:[:new, :create, :index]

  resources :daily_activities, only: [:index, :create, :new] do
    collection do
      get :export_csv
    end
  end
  
end
