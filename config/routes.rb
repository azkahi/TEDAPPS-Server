Rails.application.routes.draw do
  resources :surveys
  resources :scores
  resources :sessions
  resources :users
  post 'session_save', to: 'users#session_save'
  post 'session_get', to: 'users#session_get'
  post 'start_quiz', to: 'scores#start_quiz'
  post 'end_quiz', to: 'scores#end_quiz'
  post 'show_score', to: 'scores#show_score'
  post 'session_report', to: 'sessions#get_top'
  get 'normalize', to: 'sessions#normalize_value'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
