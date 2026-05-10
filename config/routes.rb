Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  resources :jobs, only: [ :index ]

  get  "cv",                 to: "pages#cv"
  get  "cv/preview",        to: "pages#cv_preview"
  get  "cv/download",       to: "cv_downloads#new",    as: :new_cv_download
  post "cv/download",       to: "cv_downloads#create", as: :cv_downloads
  get  "cv/download/:token", to: "cv_downloads#show",  as: :cv_download

  get "home", to: "pages#home"
  get "experience", to: "pages#experience"
  get "career", to: "pages#career"
  get "projects", to: "pages#projects"
  get "contact", to: "pages#contact"
  root "pages#home"
end
