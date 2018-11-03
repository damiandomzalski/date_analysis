Rails.application.routes.draw do
  root 'dictionaries#index'

  resources :dictionaries do
    collection do
      post :import_words
    end
  end
end
