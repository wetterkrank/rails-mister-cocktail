Rails.application.routes.draw do
  get 'doses/new'
  get 'doses/create'
  get 'cocktails/index'
  get 'cocktails/show'
  get 'cocktails/new'
  get 'cocktails/create'
  resources :cocktails, only: [ :index, :new, :create, :show ] do
    resources :doses, only: [ :new, :create ]
  end
  delete 'doses/:id', to: 'doses#destroy'
end
