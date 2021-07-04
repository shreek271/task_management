Rails.application.routes.draw do
  devise_for :users

  authenticated :user do
    root :to => 'tasks#index', as: :authenticated_user_root

    resources :tasks, except: [:destroy] do
      member do
        patch :mark_inprogress
        patch :mark_done
      end
    end
  end
  
  root 'main_pages#home'
end
