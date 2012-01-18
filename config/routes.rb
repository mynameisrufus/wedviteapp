WeddingInvitor::Application.routes.draw do

  constraints subdomain: 'plan' do
    devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

    root to: 'users/dashboard#home'
    scope module: 'users' do
      resources :stationary, only: %w(index) do
        post 'use'
      end
      resources :weddings do
        get 'collaborators/collaborate/:token', action: :collaborate, controller: :collaborators, as: :collaborate
        %w(wording ceremony_only_wording save_the_date_wording ceremony_what ceremony_how reception_what reception_how).each do |markup_action|
          get markup_action
        end
        resource :locations, only: [] do
          get 'ceremony'
          get 'reception'
          post 'ceremony',   action: :create_ceremony
          post 'reception', action: :create_reception
          put 'ceremony',    action: :update_ceremony
          put 'reception',  action: :update_reception
        end
        resources :collaborators, except: %w(show)
        resources :guests do
          get 'preview'
          post 'approve'
          post 'reject'
          post 'tentative'
          post 'accept'
          post 'decline'
          resources :comments
        end
      end
      match 'help/:page' => 'help#page', as: :help_page
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
