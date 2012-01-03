WeddingInvitor::Application.routes.draw do

  constraints subdomain: 'planner' do
    devise_for :users

    root to: 'users/dashboard#home'
    scope module: 'users' do
      resources :stationary, only: %w(index) do
        post 'use'
      end
      resources :weddings do
        resources :guests do
          get 'preview'
          post 'approve'
          post 'reject'
          post 'tentative'
          post 'accept'
          post 'decline'
          resources :comments do
            get 'reply'
          end
        end
      end
    end
  end

  constraints subdomain: 'admin' do
    devise_for :admins
  
    root to: 'admins/dashboard#home'
    scope module: 'admins' do
      resources :weddings
      resources :agencies do
        resources :agency_designers
      end
      resources :designers do
        get :sign_in_as, on: :member
      end
      resources :users do
        get :sign_in_as, on: :member
      end
    end 
  end

  constraints subdomain: 'design' do
    devise_for :designers

    root to: 'designers/dashboard#home'
    scope module: 'designers' do
      resources :stationary do
        resources :weddings
      end
    end
  end

  # http://wedding-invite.com/i/AD8L91/george-and-mildred
  match 'i/:uuid' => 'invites#show'
  scope module: 'site' do
    root to: 'pages#home'
  end
end
