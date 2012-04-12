ManybotsGmailPizzahut::Engine.routes.draw do
  match 'toggle' => 'pizzahut#toggle', as: 'toggle'
  resource :pizzahut
  resources :meals

  root to: 'pizzahut#show'

end
