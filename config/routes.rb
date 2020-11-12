Rails.application.routes.draw do
  resources :cocktails, only: [ :index, :new, :create, :show ] do
    resources :doses, only: [ :new, :create ]
  end
  delete 'doses/:id', to: 'doses#destroy'
end
