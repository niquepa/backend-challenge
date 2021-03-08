Rails.application.routes.draw do
  resources :members do
    resources :friendships
    member do
      get 'headings'
      put 'headings', to: 'members#update_headings' # re-generate headings
    end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
