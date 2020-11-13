Rails.application.routes.draw do
  root to: 'cocktails#index'
  resources :cocktails, only: [ :index, :new, :create, :show ] do
    resources :doses, only: [ :create ]
  end
  delete 'doses/:id', to: 'doses#destroy', as: 'delete_dose'
end
