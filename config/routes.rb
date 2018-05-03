Rails.application.routes.draw do
  root 'welcome#index'
  get '/upload' => "welcome#upload"

  resources :users, only: [:index] do
    collection  do
      post :import
    end
  end

end
