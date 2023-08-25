Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  scope 'api/v1' do
    devise_for(
      :users,
      controllers: {
        # confirmations: 'api/v1/users/confirmations',
        sessions: 'api/v1/users/sessions',
        # invitations: 'api/v1/users/invitations',
        # omniauths: 'api/v1/users/omniauths',
        passwords: 'api/v1/users/passwords',
        registrations: 'api/v1/users/registrations',
        confirmations: 'api/v1/users/confirmations'
        # unlocks: 'api/v1/users/unlocks'
      },
      defaults: { format: :json }
    )
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      get 'users/authenticated', to: 'users#authenticated', as: 'authenticated'
      get 'articles/popular', to: 'articles#popular', as: 'popular_articles'
      get 'users/profile', to: 'users#profile', as: 'user_profile'
      resources :articles
      resources :likes, only: %i[create destroy]
      resources :follows, only: %i[create destroy]
      resources :comments, except: %i[show index]
      resources :users, only: %i[index]
    end
  end
end
