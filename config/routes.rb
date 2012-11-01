Timehub::Application.routes.draw do
  root :to => "static_pages#home"

  match "love" => "static_pages#love", :as => :about
  match "help" => "static_pages#help", :as => :help

  resources :projects, :only => [:index, :show, :update] do
    collection { put :populate }
    post "invoices/new" => "invoices#new"
    resources :invoices
    resources :commits do
      collection { put :populate }
    end
  end

  resources :projects, :shallow => :true, :only => [:index, :show, :update] do
    resources :invoices
    resources :activities, :only => :create
  end

  resources :invoices, :only => [:index]

  match "auth/:provider/callback" => "sessions#create"
  match "auth/failure" => "sessions#failure"

  match "login" => "sessions#new", :as => "login"
  match "logout" => "sessions#destroy", :as => "logout"

  resources :users
end
